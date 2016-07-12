//
//  OfflinePayViewController.swift
//  Perfect
//
//  Created by limao on 16/7/12.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class OfflinePayViewController: BaseViewController {
    

    var orderId: Int64 = 0
    
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView = UIWebView.init()
        
        view.addSubview(webView)
        
        webView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        let urlString = offLineURL + String(orderId) + ".page"
        let url = NSURL.init(string: urlString)
        
        let request = NSURLRequest.init(URL: url!)
        
        webView.loadRequest(request)
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
