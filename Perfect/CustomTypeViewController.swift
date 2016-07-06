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

class CustomTypeViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var id: Int64 = 0
    var collectionView: UICollectionView!
    var items: [ProductItem]?
    var articles: [ArticleItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "定制分类"
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
        
        
        NetworkHelper.instance.request(.GET, url: URLConstant.appQueryGoodsList.contant, parameters: ["qryAnyTagId": NSNumber.init(longLong: id)], completion: { [weak self](product: ProductListResponse?) in
            self?.items = product?.retObj?.rows
            self?.collectionView.reloadSections(NSIndexSet.init(index: 1))
            
        }) { (errMsg: String?, errCode: Int) in
            SVProgressHUD.showErrorWithStatus(errMsg)
        }
        
        NetworkHelper.instance.request(.GET, url: URLConstant.appArticleList.contant, parameters: ["categoryName": "场景页轮播"], completion: { (result: ArticleResponse?) in
            
                self.articles = result?.retObj?.rows
                self.collectionView.reloadSections(NSIndexSet.init(index: 0))
            }) { (msg, code) in
                SVProgressHUD.showErrorWithStatus(msg)

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
                    imageUrl.append(item.thumbnail.perfectImageurl(750, h: 236, crop: true))
                }
                
                cell.banner.imageURLStringsGroup = imageUrl
            }
           
            
          
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewCell.identifier, forIndexPath: indexPath) as! CollectionViewCell
                cell.entity = items![indexPath.row]
                return cell
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSizeMake(Tool.width, 236 / 750 * Tool.width)
        }else {
            return CGSizeMake(Tool.width / 2, Tool.width * 510.0 / 750)
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
