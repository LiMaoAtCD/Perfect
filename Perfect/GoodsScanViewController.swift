//
//  GoodsScanViewController.swift
//  Perfect
//
//  Created by limao on 16/5/30.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class GoodsScanViewController: UIViewController {
    var compositionButton: UIButton!
    var bottleButton: UIButton!
    var boxButton: UIButton!
    
    var header: UIView!
    var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.translucent = false
        
        scrollView = UIScrollView.init(frame: view.bounds)
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        header = UIView.init()
        scrollView.addSubview(header)
        header.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(scrollView)
            make.height.equalTo(400)
        }
        
        compositionButton = UIButton()
        compositionButton.setTitle("组合", forState: .Normal)
        compositionButton.backgroundColor = UIColor.brownColor()
        header.addSubview(compositionButton)
        
        bottleButton = UIButton()
        bottleButton.setTitle("酒瓶", forState: .Normal)
        bottleButton.backgroundColor = UIColor.brownColor()
        
        header.addSubview(bottleButton)
        
        boxButton = UIButton()
        boxButton.setTitle("酒盒", forState: .Normal)
        boxButton.backgroundColor = UIColor.brownColor()
        header.addSubview(boxButton)
        
        compositionButton.snp_makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(35)
            make.centerY.equalTo(header.snp_top).offset(50)
            make.centerX.equalTo(header.snp_centerX).multipliedBy(0.5)
        }
        
        bottleButton.snp_makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(35)
            make.centerY.equalTo(header.snp_top).offset(50)
            make.centerX.equalTo(header.snp_centerX).multipliedBy(1)
        }
        
        boxButton.snp_makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(35)
            make.centerY.equalTo(header.snp_top).offset(50)
            make.centerX.equalTo(header.snp_centerX).multipliedBy(1.5)
        }
        
        let mainImageView = UIImageView()
        mainImageView.image = UIImage.init(named: "jiu")
        header.addSubview(mainImageView)
        
        mainImageView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(header)
            make.top.equalTo(boxButton.snp_bottom).offset(20)
        }
        
        
        
        let biggerButton = UIButton.init(type: .Custom)
        header.addSubview(biggerButton)
        biggerButton.setImage(UIImage.init(named: "fangdajing"), forState: .Normal)
        
        biggerButton.snp_makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.left.equalTo(40)
            make.top.equalTo(100)
        }
        
        let rotateButton = UIButton.init(type: .Custom)
        header.addSubview(rotateButton)
        rotateButton.setImage(UIImage.init(named: "rotate")!, forState: .Normal)
        rotateButton.snp_makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(100)
        }
        
        
        
        let canshuImageView = UIImageView()
        scrollView.addSubview(canshuImageView)
        canshuImageView.image = UIImage.init(named: "price")
        canshuImageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(header.snp_bottom)
            make.height.equalTo(150)
        }

        let introduceImageView = UIImageView.init(frame: CGRectZero)
        introduceImageView.image = UIImage.init(named: "introduce")
        scrollView.addSubview(introduceImageView)
        introduceImageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(canshuImageView.snp_bottom)
            make.height.equalTo(400)
            make.bottom.equalTo(-44)
        }
        
        
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.whiteColor()
        view.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.bottom.left.right.equalTo(view)
            make.height.equalTo(44)
        }
        
        let payButton = UIButton.init(type: .Custom)
        payButton.setTitle("加入购物车", forState: .Normal)
        payButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        payButton.backgroundColor = UIColor.brownColor()

        
        bottomView.addSubview(payButton)
        
        payButton.snp_makeConstraints { (make) in
            make.width.equalTo(120)
            make.right.equalTo(-20)
            make.height.equalTo(30)
            make.centerY.equalTo(bottomView)
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
