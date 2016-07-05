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

        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageFromColor(UIColor.whiteColor()), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init(named: "navi_shadow")
        self.navigationController?.navigationBar.translucent = false

        fd_prefersNavigationBarHidden = true
        edgesForExtendedLayout = UIRectEdge.None

        topBanners = [FirstBannerItem]()
        customButtons = [FirstButtonItem]()
        goodTypes = [FirstGoodsTypeItem]()
        
        collection = UICollectionView.init(frame: view.bounds, collectionViewLayout: CollectionLayout())
        view.addSubview(collection)
        collection.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        collection.backgroundColor = UIColor.globalBackGroundColor()
        collection.delegate = self
        collection.dataSource = self
        collection.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.registerClass(CollectionViewBannerCell.self, forCellWithReuseIdentifier: CollectionViewBannerCell.identifier)
        collection.registerClass(CollectionViewButtonsCell.self, forCellWithReuseIdentifier: CollectionViewButtonsCell.identifier)
        collection.registerClass(CollectionViewFootCell.self, forCellWithReuseIdentifier: CollectionViewFootCell.identifier)
        collection.registerClass(Header.self, forSupplementaryViewOfKind: Header.kind, withReuseIdentifier: Header.identifier)
        collection.hidden = true
        
        SVProgressHUD.showWithStatus("正在获取商品信息")
        NetworkHelper.instance.request(.GET, url: URLConstant.appQueryIndexStaticContent.contant, parameters: nil, completion: { [weak self](res: FirstPageResponse?) in
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
        
        NetworkHelper.instance.request(.GET, url: URLConstant.appQueryGoodsList.contant, parameters: ["qryCategoryId":NSNumber.init(longLong: self.goodTypes![self.selectionSection].id),"rows": 15, "page": 1], completion: { [weak self](product: ProductListResponse?) in
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
            //MARK: 顶部处理banner 跳转
            cell.banner.clickItemOperationBlock = {
                currentIndex in
                
                let item = self.topBanners![currentIndex]
                if let action = item.linkAction where action != "" {
                    UIViewController.gotoAction( action, from: self)
                } else {
                    let articleVC = ArticleViewController.someController(ArticleViewController.self, ofStoryBoard: UIStoryboard.main)
                    articleVC.hidesBottomBarWhenPushed = true
                    articleVC.id = item.id
                    self.navigationController?.pushViewController(articleVC, animated: true)
                }
            }
            
            var imageUrls = [String]()
            if let _ = topBanners {
                for item in topBanners! {
                    let imageurl = item.imageId.perfectImageurl(375, h: 183, crop: true)
                    imageUrls.append(imageurl)
                }
            }
            cell.banner.imageURLStringsGroup = imageUrls
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewButtonsCell.identifier, forIndexPath: indexPath) as! CollectionViewButtonsCell
            
            var buttonsUrl = [String]()
            if let _ = customButtons {
                for item in customButtons! {
                    let imageurl = item.imageId.perfectImageurl(374, h: 150, crop: true)
                    buttonsUrl.append(imageurl)
                }
            }
            cell.imageView.kf_setImageWithURL(NSURL.init(string: buttonsUrl[indexPath.row])!, placeholderImage: nil , optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            
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
                NetworkHelper.instance.request(.GET, url: URLConstant.appQueryGoodsList.contant, parameters: ["qryCategoryId":NSNumber.init(longLong: self.goodTypes![self.selectionSection].id)], completion: { [weak self](product: ProductListResponse?) in
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
            return CGSizeMake(Tool.width, Tool.width * (365.0 + 20.0) / 750.0)
        } else if indexPath.section == 1 {
            return CGSizeMake(Tool.width / 2 , 150.pixelToPoint)
        } else if indexPath.section == 2 {
            return CGSizeMake(Tool.width, 70.pixelToPoint)
        }else {
            return CGSizeMake(Tool.width / 2, Tool.width * 510.0 / 750)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 3 {
            return CGSizeMake(Tool.width, 124.pixelToPoint)
        } else {
            return CGSizeZero
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            //MARK: 处理button 点击
            let item = self.customButtons![indexPath.row]
            if let action = item.linkAction {
                UIViewController.gotoAction(action, from: self)
            }
            
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
        self.minimumInteritemSpacing = 0.0
        self.minimumLineSpacing = 0.0
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
    var mainView: UIView!
    var imageView: UIImageView!
    var title: UILabel!
    var priceLabel: UILabel!
    var marketPrice: MarketLabel!
    
    var price: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.init(hexString: "#fd5b59")])
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20)], range: NSMakeRange(1, (newValue.currency as NSString).length - 1))
            priceLabel.attributedText = attributeString
        }
        
    }
    
    var entity: ProductItem? {
        willSet{
            if let _ = newValue {
                let url = newValue!.thumbnailId.perfectImageurl(355, h: 352, crop: true)
                imageView.kf_setImageWithURL(NSURL.init(string: url)!)
                title.text = newValue!.name
                marketPrice.text = newValue!.marketPrice.currency
                price = newValue!.price
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        mainView = UIView()
        self.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.left.equalTo(5.pixelToPoint)
            make.right.equalTo(-5.pixelToPoint)
            make.top.equalTo(21.pixelToPoint)
            make.bottom.equalTo(0)
        }
        mainView.backgroundColor = UIColor.whiteColor()
        mainView.layer.borderColor = UIColor.init(hexString: "#ebebeb").CGColor
        mainView.layer.borderWidth = 0.3

        
        
        
        imageView = UIImageView()
        mainView.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(mainView)
            make.height.equalTo(imageView.snp_width).multipliedBy(352.0 / 355.0)
            make.bottom.equalTo(mainView).offset(-155.pixelToPoint)
        }
        imageView.layer.borderColor = UIColor.init(hexString: "#ebebeb").CGColor
        imageView.layer.borderWidth = 0.3
        
        title = UILabel.init()
        mainView.addSubview(title)
        title.textColor = UIColor.init(hexString: "#333333")
        title.numberOfLines = 0
        title.font = UIFont.systemFontOfSize(14)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(16.pixelToPoint)
            make.top.equalTo(imageView.snp_bottom).offset(19.pixelToPoint)
        }
        
        priceLabel = UILabel.init()
        self.addSubview(priceLabel)
        priceLabel.textColor = UIColor.redColor()
        priceLabel.font = UIFont.systemFontOfSize(14)
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.top.equalTo(title.snp_bottom).offset(28.pixelToPoint)
        }
        
        marketPrice = MarketLabel.init()
        self.addSubview(marketPrice)
        marketPrice.labelColor = UIColor.init(hexString: "#999999")
        marketPrice.font = UIFont.systemFontOfSize(13)
        marketPrice.snp_makeConstraints { (make) in
            make.left.equalTo(priceLabel.snp_right).offset(7)
            make.baseline.equalTo(priceLabel)
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
        self.backgroundColor = UIColor.clearColor()
        
        banner = SDCycleScrollView.init()
        self.addSubview(banner)
        banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        banner.currentPageDotColor = UIColor.init(hexString: "#f04848")
        banner.pageDotColor = UIColor.whiteColor()
        banner.snp_makeConstraints { (make) in
            make.edges.equalTo(self).offset(UIEdgeInsetsMake(0, 0, -20.pixelToPoint, 0))
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
        self.backgroundColor = UIColor.whiteColor()
        
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        imageView.layer.borderWidth = 0.3
        imageView.layer.borderColor = UIColor.init(hexString: "#dadada").CGColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewFootCell: UICollectionViewCell {
    static let identifier = "foot"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        let title = UILabel()
        title.text = "定制酒-览"
        title.textAlignment = .Center
        title.font = UIFont.systemFontOfSize(13.0)
        title.textColor = UIColor.init(hexString: "#d0d0d0")
        self.addSubview(title)
        
        title.snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        let leftMargin = UIView()
        self.addSubview(leftMargin)
        leftMargin.backgroundColor = UIColor.init(hexString: "#d0d0d0")
        leftMargin.snp_makeConstraints { (make) in
            make.right.equalTo(title.snp_left).offset(-35.pixelToPoint)
            make.centerY.equalTo(self)
            make.width.equalTo(61.pixelToPoint)
            make.height.equalTo(1.pixelToPoint)
        }
        
        let rightMargin = UIView()
        self.addSubview(rightMargin)
        rightMargin.backgroundColor = UIColor.init(hexString: "#d0d0d0")
        rightMargin.snp_makeConstraints { (make) in
            make.left.equalTo(title.snp_right).offset(35.pixelToPoint)
            make.centerY.equalTo(self)
            make.width.equalTo(61.pixelToPoint)
            make.height.equalTo(1.pixelToPoint)
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
                    self.buttons?[i].backgroundColor = UIColor.init(hexString: "#ee304e")
                } else {
                    self.buttons?[i].setTitleColor(UIColor.init(hexString: "#333333"), forState: .Normal)
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
                make.top.equalTo(20.pixelToPoint)
                make.width.equalTo(buttonWidth)
                make.bottom.equalTo(-20.pixelToPoint)
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



