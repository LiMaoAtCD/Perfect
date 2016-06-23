//
//  CustomTypeViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/23.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class CustomTypeViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var tagID: Int64 = 0
    var collectionView: UICollectionView!
    var items: [ProductItem]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        fd_prefersNavigationBarHidden = false
        
        items = [ProductItem]()
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: CustomCollectionLayout())
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        
        collectionView.registerClass(FirstDetailCollectionCell.self, forCellWithReuseIdentifier: FirstDetailCollectionCell.identifier)
        
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.registerClass(CollectionViewBannerCell.self, forCellWithReuseIdentifier: CollectionViewBannerCell.identifier)
        
        NetworkHelper.instance.request(.GET, url: URLConstant.ProductList.contant, parameters: ["qryAnyTagId": NSNumber.init(longLong: tagID)], completion: { [weak self](product: ProductListResponse?) in
            print(product)
            self?.items = product?.retObj?.rows
            self?.collectionView.reloadSections(NSIndexSet.init(index: 1))
            
        }) { (errMsg: String?, errCode: Int) in
            
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
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewBannerCell.identifier, forIndexPath: indexPath) as! CollectionViewBannerCell
            //MARK: 处理banner 跳转
            cell.banner.clickItemOperationBlock = {
                currentIndex in
                
                let detail = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("GoodsDetailViewController") as! GoodsDetailViewController
                detail.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(detail, animated: true)
            }
            
            let imageUrl =  [
                "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"
            ]
            
            //            if let _ = topBanners {
            //                for item in topBanners! {
            //                    imageUrl.append(item.imgUrl!)
            //                }
            //            }
            
            cell.banner.placeholderImage = UIImage.init(named: "h8")
            cell.banner.imageURLStringsGroup = imageUrl
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewCell.identifier, forIndexPath: indexPath) as! CollectionViewCell
            let item = items![indexPath.row]
            
            cell.entity = item
            
            return cell
            
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSizeMake(Tool.width, 250)
        }else {
            return CGSizeMake(Tool.width / 2 - 5, 200)
        }
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            let detail = GoodsDetailViewController.someController(GoodsDetailViewController.self, ofStoryBoard: UIStoryboard.main)
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
class CustomCollectionLayout: UICollectionViewFlowLayout {
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
