//
//  FirstPageViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/14.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import SnapKit
import SDCycleScrollView
import Kingfisher
import SVProgressHUD

class FirstPageViewController: BaseViewController, SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collection : UICollectionView!
    var topBanners: [FirstBannerItem]?
    var customButtons: [FirstButtonItem]?
    var goodTypes: [FirstGoodsTypeItem]?
    var goods: [ProductItem]?
    
    var selectionSection = 0 //  当前选中的分类

    override func viewDidLoad() {
        super.viewDidLoad()

        fd_prefersNavigationBarHidden = true
        edgesForExtendedLayout = UIRectEdge.None

        topBanners = [FirstBannerItem]()
        customButtons = [FirstButtonItem]()
        goodTypes = [FirstGoodsTypeItem]()
        
        collection = UICollectionView.init(frame: view.bounds, collectionViewLayout: CollectionLayout())
        view.addSubview(collection)
        
        collection.backgroundColor = UIColor.lightGrayColor()
        collection.delegate = self
        collection.dataSource = self
        collection.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.registerClass(CollectionViewBannerCell.self, forCellWithReuseIdentifier: CollectionViewBannerCell.identifier)
        collection.registerClass(CollectionViewButtonsCell.self, forCellWithReuseIdentifier: CollectionViewButtonsCell.identifier)
        collection.registerClass(CollectionViewFootCell.self, forCellWithReuseIdentifier: CollectionViewFootCell.identifier)
        collection.registerClass(Header.self, forSupplementaryViewOfKind: Header.kind, withReuseIdentifier: Header.identifier)
        collection.hidden = true
        
        SVProgressHUD.showWithStatus("正在获取商品信息")
        NetworkHelper.instance.request(.GET, url: URLConstant.FirstPage.contant, parameters: nil, completion: { [weak self](res: FirstPageResponse?) in
                SVProgressHUD.dismiss()
                self?.topBanners = res?.retObj?.topBanners
                self?.customButtons = res?.retObj?.buttons
                self?.fetchProductsByGoodTypes(res?.retObj?.types)
                self?.collection.reloadData()
                self?.collection.hidden = false

        }) { (errMsg: String?, errCode: Int) in
            SVProgressHUD.showErrorWithStatus(errMsg)
        }
    }
    
    //根据分类ID获取商品列表
    
    func fetchProductsByGoodTypes(types:[FirstGoodsTypeItem]?) {
        self.goodTypes = types
        if let _ = self.goodTypes where self.goodTypes!.count > 0 {
            for i in 0...self.goodTypes!.count - 1 {
                if self.goodTypes![i].isDefault == true {
                    self.selectionSection = i
                }
            }
        }
        
        NetworkHelper.instance.request(.GET, url: URLConstant.ProductList.contant, parameters: ["qryCategoryId":NSNumber.init(longLong: self.goodTypes![self.selectionSection].id),"rows": 15, "page": 1], completion: { [weak self](product: ProductListResponse?) in
                self?.goods = product?.retObj?.rows
                self?.collection.reloadSections(NSIndexSet.init(index: 3))
            }) { (errMsg: String?, errCode: Int) in
                SVProgressHUD.showErrorWithStatus(errMsg)
        }
    }
    
    
    //MARK: Datasource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            if let btns = self.customButtons {
                return btns.count
            } else {
                return 0
            }
        } else if section == 2 {
            return 1
        } else {
            if let _ = goods {
                return goods!.count
            } else {
                return 0
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewBannerCell.identifier, forIndexPath: indexPath) as! CollectionViewBannerCell
            //MARK: 处理banner 跳转
            cell.banner.clickItemOperationBlock = {
                currentIndex in
                
                let item = self.topBanners![currentIndex]
                let id = item.id
                let action  = item.linkAction!
                
                print("id:\(id) & action: \(action)")
                
                
           
                let detail = CustomTypeViewController.someController(CustomTypeViewController.self, ofStoryBoard: UIStoryboard.main)
                detail.id = id
                detail.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(detail, animated: true)
            }
            
            var imageUrl = [String]()
            if let _ = topBanners {
                for item in topBanners! {
                    imageUrl.append("\(item.imageId)")
                }
            }
          
            cell.banner.placeholderImage = UIImage.init(named: "h8")
            cell.banner.imageURLStringsGroup = imageUrl
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewButtonsCell.identifier, forIndexPath: indexPath) as! CollectionViewButtonsCell
            
            var buttonsUrl = [String]()
            if let _ = customButtons {
                for item in customButtons! {
                    let url = item.imageId
                    buttonsUrl.append("\(url)")
                }
            }
            
            cell.imageView.kf_setImageWithURL(NSURL.init(string: buttonsUrl[indexPath.row])!, placeholderImage: UIImage.init(named: "h8"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewFootCell.identifier, forIndexPath: indexPath) as! CollectionViewFootCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewCell.identifier, forIndexPath: indexPath) as! CollectionViewCell
            let item = goods![indexPath.row]
            
            cell.entity = item
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if indexPath.section == 3 {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(Header.kind, withReuseIdentifier: Header.identifier, forIndexPath: indexPath) as! Header
            
            var types = ["","",""]
            if let _ = goodTypes where goodTypes!.count > 0 {
                for i in 0...goodTypes!.count - 1 {
                    types[i] = goodTypes![i].title!
                }
            }
            
            
            header.segmentControl.titles = types
            header.segmentControl.currentIndex = selectionSection
            //MARK: 切换种类
            header.segmentControl.selectionHandler = { index in
                print("index: \(index)")
                self.selectionSection = index
                NetworkHelper.instance.request(.GET, url: URLConstant.ProductList.contant, parameters: ["qryCategoryId":NSNumber.init(longLong: self.goodTypes![self.selectionSection].id)], completion: { [weak self](product: ProductListResponse?) in
                    self?.goods = product?.retObj?.rows
                 
                    self?.collection.reloadSections(NSIndexSet.init(index: 3))
                }) { (errMsg: String?, errCode: Int) in
                }
            }

            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    //MARK: Delegate

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSizeMake(Tool.width, 250)
        } else if indexPath.section == 1 {
            return CGSizeMake(Tool.width / 2 - 0.5, 50)
        } else if indexPath.section == 2 {
            return CGSizeMake(Tool.width, 50)
        }else {
            return CGSizeMake(Tool.width / 2 - 5, 200)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 3 {
            return CGSizeMake(Tool.width, 50)
        } else {
            return CGSizeZero
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            //MARK: 处理button 点击
            let item = self.customButtons![indexPath.row]
            let action = item.linkAction
            print("action: \(action)")
            
            let detail = CustomTypeViewController.someController(CustomTypeViewController.self, ofStoryBoard: UIStoryboard.main)
            detail.id = action!.actionID
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
            
        } else if indexPath.section == 3 {
            //MARK: 处理普通商品
            
            let detail = GoodsDetailViewController.someController(GoodsDetailViewController.self, ofStoryBoard: UIStoryboard.main)
            detail.id = self.goods![indexPath.row].id
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//MARK: Layout
class CollectionLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumInteritemSpacing = 0.5
        self.minimumLineSpacing = 0.5
        if #available(iOS 9.0, *) {
            self.sectionHeadersPinToVisibleBounds = true
        } else {
            // Fallback on earlier versions
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: CollectionViewCells
class CollectionViewCell: UICollectionViewCell {
    static let identifier = "cell"
    
    var imageView: UIImageView!
    var title: UILabel!
    var price: UILabel!
    var marketPrice: MarketLabel!
    
    var entity: ProductItem? {
        willSet{
            if let _ = newValue {
                imageView.kf_setImageWithURL(NSURL.init(string: "\(newValue!.imageId)")!)
                title.text = newValue!.fullName
                marketPrice.text = newValue!.marketPrice.currency
                price.text = newValue!.price.currency
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(100)
        }
        title = UILabel.init()
        self.addSubview(title)
        title.textColor = UIColor.blackColor()
        title.numberOfLines = 0
        title.font = UIFont.systemFontOfSize(14)
        title.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp_bottom)
        }
        
        price = UILabel.init()
        self.addSubview(price)
        price.textColor = UIColor.redColor()
        price.font = UIFont.systemFontOfSize(14)
        price.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.top.equalTo(title.snp_bottom)
        }
        
        marketPrice = MarketLabel.init()
        self.addSubview(marketPrice)
        marketPrice.labelColor = UIColor.lightGrayColor()
        marketPrice.font = UIFont.systemFontOfSize(12)
        marketPrice.snp_makeConstraints { (make) in
            make.left.equalTo(price.snp_right).offset(8)
            make.centerY.equalTo(price.snp_centerY)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CollectionViewBannerCell: UICollectionViewCell {
    static let identifier = "banner"
    var banner: SDCycleScrollView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        banner = SDCycleScrollView.init()
        self.addSubview(banner)
        banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        banner.currentPageDotColor = UIColor.whiteColor()
        
        banner.snp_makeConstraints { (make) in
            make.edges.equalTo(self).offset(UIEdgeInsetsMake(0, 0, -20, 0))
        }
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewButtonsCell: UICollectionViewCell {
    static let identifier = "button"
    
    var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellowColor()
        
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewFootCell: UICollectionViewCell {
    static let identifier = "foot"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
        
        let title = UILabel()
        title.text = "预览"
        title.textAlignment = .Center
        title.textColor = UIColor.whiteColor()
        self.addSubview(title)
        
        title.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Header
class Header: UICollectionReusableView {
    
    static let identifier = "header"
    static let kind = "UICollectionElementKindSectionHeader"
    
    var segmentControl: SegmentControlView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        segmentControl = SegmentControlView.init()
        self.addSubview(segmentControl)
        
        
        segmentControl.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 选择列表
class SegmentControlView : UIView {
    
    var buttons:[UIButton]?
    
    var selectionHandler: (Int -> Void)?
    
    var prefixIndex: Int = 0
    var currentIndex: Int = 0 {
        willSet{
            for i in 0...2 {
                if newValue == i {
                    self.buttons?[i].setTitleColor(UIColor.whiteColor(), forState: .Normal)
                    self.buttons?[i].backgroundColor = UIColor.brownColor()
                } else {
                    self.buttons?[i].setTitleColor(UIColor.blackColor(), forState: .Normal)
                    self.buttons?[i].backgroundColor = UIColor.whiteColor()
                }
            }
        }
    }
    
    var titles:[String]? {
        willSet{
            if let _ = newValue {
                for i in 0...2 {
                    buttons?[i].setTitle(newValue![i], forState: .Normal)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttons = [UIButton]()
        let buttonMargin: CGFloat = 10.0
        let buttonWidth = (Tool.width - 6 * buttonMargin) / 3
        
        for i in 0...2 {
            let button = UIButton.init(type: .Custom)
            button.tag = i
            self.addSubview(button)
            
            button.frame = CGRectMake(buttonMargin * ((CGFloat(i) * 2) + 1) + CGFloat(i) * buttonWidth, 3, buttonWidth, frame.size.height - 6)
            
            let leftOffset = buttonMargin * ((CGFloat(i) * 2) + 1) + CGFloat(i) * buttonWidth
            button.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self).offset(leftOffset)
                make.top.equalTo(3)
                make.width.equalTo(buttonWidth)
                make.bottom.equalTo(-3)
            })
            
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(self.didClickItem(_:)), forControlEvents: .TouchUpInside)
            buttons?.append(button)
        }
    }
    
    func didClickItem(btn: UIButton) {
        self.currentIndex = btn.tag
        if prefixIndex != currentIndex {
            self.selectionHandler?(btn.tag)
        }
        self.prefixIndex = self.currentIndex
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension String {
    var actionID: Int64 {
        let arr = self.componentsSeparatedByString(":")
        if arr.count > 0 {
            let id = Int64(arr.last!)
            return id ?? 0
        } else {
            return 0
        }
        
    }
    var actionType: String {
        let arr = self.componentsSeparatedByString(":")
        if arr.count > 0 {
            let type = arr[1]
            return type
        } else {
            return ""
        }
    }
}
