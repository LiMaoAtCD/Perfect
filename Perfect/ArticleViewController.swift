//
//  ArticleViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/25.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class ArticleViewController: BaseViewController {

    var id: Int64 = 0
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.translucent = false
        webView = UIWebView()
        self.view.addSubview(webView)
        webView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        let urlString = id.article
        let url = NSURL.init(string: urlString)!
        
        webView.loadRequest(NSURLRequest.init(URL: url))
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
