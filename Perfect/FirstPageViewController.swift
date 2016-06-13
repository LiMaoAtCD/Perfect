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

class FirstPageViewController: UIViewController, SDCycleScrollViewDelegate {

    
    var scrollView: UIScrollView!
    
    var topperBackGroundView: UIView!
    
    
    var banner: SDCycleScrollView!
    
    var customButtonsView: UIView!
    
    var tipView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.hidden = true
        fd_prefersNavigationBarHidden = true
        
        scrollView = UIScrollView.init(frame: view.frame)
        view.addSubview(scrollView)
        
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        topperBackGroundView = UIView()
        scrollView.addSubview(topperBackGroundView)
        topperBackGroundView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(scrollView)
            make.height.equalTo(500)
        }
        
        
        banner = SDCycleScrollView.init(frame: self.view.bounds, delegate: self, placeholderImage: UIImage.init(named: "placeholder")!)
        topperBackGroundView.addSubview(banner)
        
        banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        banner.currentPageDotColor = UIColor.whiteColor()
        
        banner.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(200)
        }
        banner.clickItemOperationBlock = {
             currentIndex in
        }
        
        let imageURLs = [
            "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
            "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
            "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"
        ]

        banner.imageURLStringsGroup = imageURLs
        
        customButtonsView = UIView()
        
        topperBackGroundView.addSubview(customButtonsView)
        
        
        let layout = UICollectionViewFlowLayout.init()
        
        
        let collectionView = UICollectionView.init(frame: CGRectZero, collectionViewLayout: layout)
        
        
        NetworkHelper.instance.request(.GET, url:  URLConstant.FirstPage.contant, parameters: nil) { (res: FirstPageResponse?) in
            print(res?.retObj?.topBanners?.first?.imgUrl)
        }

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
