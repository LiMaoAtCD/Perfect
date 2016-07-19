//
//  CustomTypeViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/23.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SDCycleScrollView
import SVProgressHUD
import MJRefresh

class CustomTypeViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var id: Int64 = 0
    var collectionView: UICollectionView!
    var items: [ProductItem]?
    var articles: [ArticleItem]?
    var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fd_prefersNavigationBarHidden = false
        
        items = [ProductItem]()
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: CustomCollectionLayout())
        collectionView.backgroundColor = UIColor.globalBackGroundColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        
        collectionView.registerClass(FirstDetailCollectionCell.self, forCellWithReuseIdentifier: FirstDetailCollectionCell.identifier)
        
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.registerClass(CustomTypeBannerCell.self, forCellWithReuseIdentifier: CustomTypeBannerCell.identifier)
        
        
        
        let footer = MJRefreshAutoNormalFooter.init { [weak self]() -> Void in
            self?.fetchGoods()
        }
        footer.automaticallyHidden = true
        footer.setTitle("- 没有更多了 -", forState: MJRefreshState.NoMoreData)
        self.collectionView.mj_footer = footer
        
        let header = MJRefreshNormalHeader.init {
            [weak self] in
            self?.fetchData()
        }
        self.collectionView.mj_header = header
        
        self.collectionView.mj_header.beginRefreshing()
    }
    
    func fetchData() {
        
        NetworkHelper.instance.request(.GET, url: URLConstant.appQueryGoodsList.contant, parameters: ["qryTagId": NSNumber.init(longLong: id), "rows": 20, "page": 1], completion: { [weak self](product: ProductListResponse?) in
            self?.items = product?.retObj?.rows
            self?.collectionView.reloadSections(NSIndexSet.init(index: 1))
            self?.collectionView.mj_header.endRefreshing()
            
        }) { (errMsg: String?, errCode: Int) in
            SVProgressHUD.showErrorWithStatus(errMsg)
            self.collectionView.mj_header.endRefreshing()
        }
        
        NetworkHelper.instance.request(.GET, url: URLConstant.appArticleList.contant, parameters: ["categoryName": "场景页轮播"], completion: { (result: ArticleResponse?) in
            
            self.articles = result?.retObj?.rows
            self.collectionView.reloadSections(NSIndexSet.init(index: 0))
        }) { (msg, code) in
            SVProgressHUD.showErrorWithStatus(msg)
            
        }

    }
    
    func fetchGoods() {
        NetworkHelper.instance.request(.GET, url: URLConstant.appQueryGoodsList.contant, parameters: ["qryAnyTagId": NSNumber.init(longLong: id), "rows": 20, "page": 1], completion: { [weak self](product: ProductListResponse?) in
            
            guard let rows = product?.retObj?.rows else {
                self?.collectionView.mj_footer.endRefreshing()
                return
            }
            
            self?.items?.appendContentsOf(rows)
            self?.collectionView.reloadSections(NSIndexSet.init(index: 1))
            
            if rows.count < 20 {
                self?.collectionView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self?.collectionView.mj_footer.endRefreshing()
            }
        }) { (errMsg: String?, errCode: Int) in
            SVProgressHUD.showErrorWithStatus(errMsg)
            self.collectionView.mj_footer.endRefreshing()
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {return items!.count}
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CustomTypeBannerCell.identifier, forIndexPath: indexPath) as! CustomTypeBannerCell
            //MARK: 处理banner 跳转
            cell.banner.clickItemOperationBlock = {
                currentIndex in
                let item = self.articles![currentIndex]
                if let action = item.linkAction where action != "" {
                    UIViewController.gotoAction( action, from: self)
                } else {
                    let articleVC = ArticleViewController.someController(ArticleViewController.self, ofStoryBoard: UIStoryboard.main)
                    articleVC.hidesBottomBarWhenPushed = true
                    articleVC.id = Int64(item.id)
                    self.navigationController?.pushViewController(articleVC, animated: true)
                }
            }
            
            
            if let _ = articles {
                var imageUrl: [String] = [String]()
                for item in articles! {
                    imageUrl.append(item.thumbnail.perfectImageurl(750, h: 580, crop: true))
                }
                
                cell.banner.imageURLStringsGroup = imageUrl
            }
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewCell.identifier, forIndexPath: indexPath) as! CollectionViewCell
                cell.entity = items![indexPath.row]
                cell.layoutIfNeeded()
                return cell
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSizeMake(Tool.width, (580 + 85) / 750 * Tool.width)
        }else {
            return CGSizeMake(Tool.width / 2, Tool.width * 580 / 750)
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            let detail = GoodsDetailViewController.someController(GoodsDetailViewController.self, ofStoryBoard: UIStoryboard.main)
            detail.hidesBottomBarWhenPushed = true
            detail.id = self.items![indexPath.row].id
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: Layout
class CustomCollectionLayout: UICollectionViewFlowLayout {
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

class FirstDetailCollectionCell: UICollectionViewCell {
    
    static let identifier = "FirstDetailCollectionCell"
    var contentImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentImageView = UIImageView()
        self.addSubview(contentImageView)
        contentImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomTypeBannerCell: UICollectionViewCell {
    static let identifier = "CustomTypeBannerCell"
    var banner: SDCycleScrollView!
    var typeImageView: UIImageView!
    var customTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        banner = SDCycleScrollView.init()
        self.addSubview(banner)
        banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        banner.currentPageDotColor = UIColor.globalRedColor()
        banner.pageDotColor = UIColor.whiteColor()
        banner.snp_makeConstraints { (make) in
            make.edges.equalTo(self).offset(UIEdgeInsetsMake(0, 0, -85.pixelToPoint, 0))
        }
        
        typeImageView = UIImageView.init(image: UIImage.init(named: "type_title_bottom"))
        self.addSubview(typeImageView)
        typeImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(130.pixelToPoint)
            make.height.equalTo(78.pixelToPoint)
        }
        customTitleLabel = UILabel()
        customTitleLabel.text = "精选婚宴酒"
        customTitleLabel.backgroundColor = UIColor.init(white: 1.0, alpha: 0.5)
        customTitleLabel.textColor = UIColor.globalDarkColor()
        customTitleLabel.font = UIFont.systemFontOfSize(14.0)
        self.addSubview(customTitleLabel)
        customTitleLabel.snp_makeConstraints { (make) in
            make.center.equalTo(typeImageView)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
