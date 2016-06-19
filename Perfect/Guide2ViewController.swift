//
//  Guide2ViewController.swift
//  Perfect
//
//  Created by limao on 16/5/31.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class Guide2ViewController: BaseViewController {

    var scrollView: UIScrollView!
    
    let ImageHeight = 400
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView.init(frame: view.bounds)
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        for i in 0 ... 10 {
            let contentImageView = UIImageView.init()
            scrollView.addSubview(contentImageView)
            if i != 10 {
                contentImageView.snp_makeConstraints(closure: { (make) in
                    make.left.right.equalTo(view)
                    make.top.equalTo(scrollView).offset(i * ImageHeight)
                    make.height.equalTo(ImageHeight)
                })
            } else {
                contentImageView.snp_makeConstraints(closure: { (make) in
                    make.left.right.equalTo(view)
                    make.top.equalTo(scrollView).offset(i * ImageHeight)
                    make.height.equalTo(ImageHeight)
                    make.bottom.equalTo(0)
                })
            }
            
            contentImageView.image = UIImage.init(named: "introduce")
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
