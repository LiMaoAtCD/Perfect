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
import MJRefresh


class FirstPageViewController: BaseViewController, SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collection : UICollectionView!
    var topBanners: [FirstBannerItem]?
    var customButtons: [FirstButtonItem]?
    var goodTypes: [FirstGoodsTypeItem]?
    var goods: [ProductItem]?
//    var leftGoods: [ProductItem]?
//    var centerGoods: [ProductItem]?
//    var rightGoods: [ProductItem]?

    var selectionSection = 0 //  当前选中的分类
    var currentPage: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.navigationItem.title = "个性化定制平台"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView())
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
        
        let footer = MJRefreshAutoNormalFooter.init { [weak self]() -> Void in
            self?.fetchGoods()
        }
        footer.automaticallyHidden = true
        footer.setTitle("- 没有更多了 -", forState: MJRefreshState.NoMoreData)
        self.collection.mj_footer = footer
    }
    
    func fetchGoods() {
        NetworkHelper.instance.request(.GET, url: URLConstant.appQueryGoodsList.contant, parameters: ["qryCategoryId":NSNumber.init(longLong: self.goodTypes![self.selectionSection].id),"rows": 20, "page": currentPage], completion: { [weak self](product: ProductListResponse?) in
            self?.collection.mj_footer.hidden = true
            guard let rows = product?.retObj?.rows else {
                self?.collection.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            
            if rows.count >= 20 {
                self?.collection.mj_footer?.endRefreshing()
                self?.currentPage = self!.currentPage + 1
            } else {
                self?.collection.mj_footer.endRefreshingWithNoMoreData()
            }
            
            
            self?.goods?.appendContentsOf(rows)
            self?.collection.reloadSections(NSIndexSet.init(index: 3))
            self?.collection.mj_footer.hidden = false

        }) { (errMsg: String?, errCode: Int) in
            SVProgressHUD.showErrorWithStatus(errMsg)
            self.collection.mj_footer?.endRefreshing()
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
        
        NetworkHelper.instance.request(.GET, url: URLConstant.appQueryGoodsList.contant, parameters: ["qryCategoryId":NSNumber.init(longLong: self.goodTypes![self.selectionSection].id),"rows": 20, "page": currentPage], completion: { [weak self](product: ProductListResponse?) in
                self?.goods = product?.retObj?.rows
                self?.collection.reloadSections(NSIndexSet.init(index: 3))
                self?.currentPage = self!.currentPage + 1
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
            return 1
        } else if section == 2 {
            if let btns = self.customButtons {
                return btns.count
            } else {
                return 0
            }
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
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewFootCell.identifier, forIndexPath: indexPath) as! CollectionViewFootCell
            return cell
            
        } else if indexPath.section == 2 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewButtonsCell.identifier, forIndexPath: indexPath) as! CollectionViewButtonsCell
            
            var buttonsUrl = [String]()
            if let _ = customButtons {
                for item in customButtons! {
                    let imageurl = item.imageId.perfectImageurl(374, h: 150, crop: true)
                    buttonsUrl.append(imageurl)
                }
            }
            cell.imageView.kf_setImageWithURL(NSURL.init(string: buttonsUrl[indexPath.row])!, placeholderImage: nil , optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            
            if indexPath.row % 2 == 0 {
                cell.imageView.snp_remakeConstraints(closure: { (make) in
                    make.left.equalTo(10.pixelToPoint)
                    make.top.equalTo(0.pixelToPoint)
                    make.right.equalTo(-5.pixelToPoint)
                    make.bottom.equalTo(-10.pixelToPoint)
                })
            } else {
                cell.imageView.snp_remakeConstraints(closure: { (make) in
                    make.right.equalTo(-10.pixelToPoint)
                    make.top.equalTo(0.pixelToPoint)
                    make.left.equalTo(5.pixelToPoint)
                    make.bottom.equalTo(-10.pixelToPoint)
                })
            }
            
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
                self.selectionSection = index
                self.currentPage = 1
                NetworkHelper.instance.request(.GET, url: URLConstant.appQueryGoodsList.contant, parameters: ["qryCategoryId":NSNumber.init(longLong: self.goodTypes![self.selectionSection].id),"rows": 20, "page": self.currentPage], completion: { [weak self](product: ProductListResponse?) in
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
            return CGSizeMake(Tool.width, Tool.width * (374.0 + 10.0) / 750.0)
        
        } else if indexPath.section == 1 {
            return CGSizeMake(Tool.width, 100.pixelToPoint)

        } else if indexPath.section == 2 {
            return CGSizeMake(Tool.width / 2 , 160.pixelToPoint)

        }else {
            return CGSizeMake(Tool.width / 2, Tool.width * 580.0 / 750)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 3 {
            return CGSizeMake(Tool.width, 90.pixelToPoint)
        } else {
            return CGSizeZero
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
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
//        if #available(iOS 9.0, *) {
            self.sectionHeadersPinToVisibleBounds = true
//        } else {
//            // Fallback on earlier versions
//        }
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
    var detailTitle: UILabel!
    var priceLabel: UILabel!
//    var marketPrice: MarketLabel!
    
    var price: Float = 0.0 {
        willSet {
            let attributeString = NSMutableAttributedString.init(string: newValue.currency, attributes: [NSForegroundColorAttributeName: UIColor.globalRedColor()])
            attributeString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(14)], range: NSMakeRange(0, 1))
            attributeString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(14)], range: NSMakeRange(1, (newValue.currency as NSString).length - 1))
            priceLabel.attributedText = attributeString
        }
        
    }
    
    var entity: ProductItem? {
        willSet{
            if let _ = newValue {
                let url = newValue!.thumbnailId.perfectImageurl(355, h: 352, crop: true)
                imageView.kf_setImageWithURL(NSURL.init(string: url)!)
                title.text = newValue!.name
//                marketPrice.text = newValue!.marketPrice.currency
                price = newValue!.price
                detailTitle.text = "浪去特曲 53点啊离开家大量可激发了房间卡"
                
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        mainView = UIView()
        self.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        mainView.backgroundColor = UIColor.whiteColor()
        mainView.layer.borderColor = UIColor.init(hexString: "#ebebeb").CGColor
        mainView.layer.borderWidth = 0.3

        
        
        
        imageView = UIImageView()
        mainView.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(mainView)
            make.height.equalTo(imageView.snp_width).multipliedBy(390.0 / 375.0)
//            make.bottom.equalTo(mainView).offset(-155.pixelToPoint)
        }
//        imageView.layer.borderColor = UIColor.init(hexString: "#ebebeb").CGColor
//        imageView.layer.borderWidth = 0.3
        
        title = UILabel.init()
        mainView.addSubview(title)
        title.textColor = UIColor.globalDarkColor()
//        title.numberOfLines = 0
        title.font = UIFont.systemFontOfSize(14)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(16.pixelToPoint)
            make.right.equalTo(-10.pixelToPoint)
            make.top.equalTo(imageView.snp_bottom).offset(10.pixelToPoint)
        }
        
        detailTitle = UILabel.init()
        detailTitle.numberOfLines = 0
        mainView.addSubview(detailTitle)
        detailTitle.textColor = UIColor.globalLightGrayColor()
        detailTitle.font = UIFont.systemFontOfSize(14)
        detailTitle.snp_makeConstraints { (make) in
            make.left.equalTo(16.pixelToPoint)
            make.right.equalTo(-10.pixelToPoint)
            make.top.equalTo(title.snp_bottom).offset(5.pixelToPoint)
        }
        
        
        priceLabel = UILabel.init()
        self.addSubview(priceLabel)
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(title)
            make.top.equalTo(detailTitle.snp_bottom).offset(28.pixelToPoint).priority(250)
            make.bottom.equalTo(self).offset(-15.pixelToPoint)
        }
        
        let customLabel = UILabel.init()
        self.addSubview(customLabel)
        customLabel.text = "立即定制"
        customLabel.font = UIFont.systemFontOfSize(14)
        customLabel.textColor =  UIColor.globalRedColor()
        customLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(priceLabel)
            make.right.equalTo(self).offset(-15.pixelToPoint)
        }
        
        
        
        
//        marketPrice = MarketLabel.init()
//        self.addSubview(marketPrice)
//        marketPrice.labelColor = UIColor.init(hexString: "#999999")
//        marketPrice.font = UIFont.systemFontOfSize(13)
//        marketPrice.snp_makeConstraints { (make) in
//            make.left.equalTo(priceLabel.snp_right).offset(7)
//            make.baseline.equalTo(priceLabel)
//        }
//        
        
        
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
        banner.currentPageDotColor = UIColor.globalRedColor()
        banner.pageDotColor = UIColor.whiteColor()
        banner.snp_makeConstraints { (make) in
            make.edges.equalTo(self).offset(UIEdgeInsetsMake(0, 0, -10.pixelToPoint, 0))
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
//        imageView.snp_makeConstraints { (make) in
//            make.edges.equalTo(self)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewFootCell: UICollectionViewCell {
    static let identifier = "foot"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        let titleImageView = UIImageView.init(image: UIImage.init(named: "first_adtitle"))
        self.addSubview(titleImageView)
        
        titleImageView.snp_makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(260.pixelToPoint)
            make.height.equalTo(74.pixelToPoint)
        }
        
        let line = UIView()
        self.addSubview(line)
        line.backgroundColor = UIColor.init(hexString: "#e9edf2")
        line.snp_makeConstraints { (make) in
            make.top.equalTo(titleImageView.snp_bottom)
            make.left.right.equalTo(self)
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
        
        let line = UIView()
        self.addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(9.pixelToPoint)
            make.top.equalTo(self).offset(-9.pixelToPoint)
        }
        line.backgroundColor = UIColor.init(hexString: "#e9edf2")
        
        
        segmentControl = SegmentControlView.init()
        self.addSubview(segmentControl)
        segmentControl.snp_makeConstraints { (make) in
            make.left.equalTo(0.pixelToPoint)
            make.right.equalTo(0.pixelToPoint)
            make.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: 选择列表
class SegmentControlView : UIView {
    
    var buttons:[UIButton]?
    var bottomViews: [UIView]?
    var selectionHandler: (Int -> Void)?
    
    var prefixIndex: Int = 0
    var currentIndex: Int = 0 {
        willSet{
            for i in 0...2 {
                if newValue == i {
                    self.buttons?[i].setTitleColor(UIColor.globalDarkColor(), forState: .Normal)
                    self.bottomViews?[i].backgroundColor = UIColor.globalRedColor()
                } else {
                    self.buttons?[i].setTitleColor(UIColor.init(hexString: "#e6e7e8"), forState: .Normal)
                    self.bottomViews?[i].backgroundColor = UIColor.whiteColor()
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
        bottomViews = [UIView]()
        
        let button0 = UIButton.init(type: .Custom)
        button0.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        button0.tag = 0
        self.addSubview(button0)
        button0.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.width.equalTo(120.pixelToPoint)
            make.height.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        let view0 = UIView()
        view0.backgroundColor = UIColor.globalRedColor()
        self.addSubview(view0)
        view0.snp_makeConstraints { (make) in
            make.left.right.equalTo(button0)
            make.height.equalTo(4.pixelToPoint)
            make.bottom.equalTo(self)
        }
        
        let button1 = UIButton.init(type: .Custom)
        button1.tag = 1
        button1.titleLabel?.font = UIFont.systemFontOfSize(14.0)

        self.addSubview(button1)
        button1.snp_makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(120.pixelToPoint)
            make.height.equalTo(self)
        }
        
        
        let view1 = UIView()
        view1.backgroundColor = UIColor.globalRedColor()
        self.addSubview(view1)
        view1.snp_makeConstraints { (make) in
            make.left.right.equalTo(button1)
            make.height.equalTo(4.pixelToPoint)
            make.bottom.equalTo(self)
        }
        
        let button2 = UIButton.init(type: .Custom)
        button2.tag = 2
        button2.titleLabel?.font = UIFont.systemFontOfSize(14.0)

        self.addSubview(button2)
        button2.snp_makeConstraints { (make) in
            make.right.equalTo(self)
            make.width.equalTo(120.pixelToPoint)
            make.height.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        let view2 = UIView()
        view2.backgroundColor = UIColor.globalRedColor()
        self.addSubview(view2)
        view2.snp_makeConstraints { (make) in
            make.left.right.equalTo(button2)
            make.height.equalTo(4.pixelToPoint)
            make.bottom.equalTo(self)
        }
        
        button0.addTarget(self, action: #selector(self.didClickItem(_:)), forControlEvents: .TouchUpInside)
        buttons?.append(button0)
        
        button1.addTarget(self, action: #selector(self.didClickItem(_:)), forControlEvents: .TouchUpInside)
        buttons?.append(button1)
        
        button2.addTarget(self, action: #selector(self.didClickItem(_:)), forControlEvents: .TouchUpInside)
        buttons?.append(button2)
        
        bottomViews?.append(view0)
        bottomViews?.append(view1)
        bottomViews?.append(view2)

        
        
    }
    
    func didClickItem(btn: UIButton) {
        self.selectionHandler?(btn.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



