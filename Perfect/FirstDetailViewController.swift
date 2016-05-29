//
//  FirstDetailViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/29.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class FirstDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)

        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSizeMake((Tools.width - 2) / 2, 200)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.registerClass(FirstDetailCollectionCell.self, forCellWithReuseIdentifier: FirstDetailCollectionCell.identifier)
        
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FirstDetailCollectionCell.identifier, forIndexPath: indexPath) as! FirstDetailCollectionCell
        
        cell.contentImageView.image = UIImage.init(named: "goods_item")
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detail = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FirstGoodsDetailViewController") as! FirstGoodsDetailViewController
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)

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
