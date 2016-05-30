//
//  SecondDetailViewController.swift
//  Perfect
//
//  Created by limao on 16/5/30.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class SecondDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var items: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        tableView = UITableView.init(frame: view.bounds, style: .Plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(SecondDetailTableViewCell.self, forCellReuseIdentifier: "SecondDetailTableViewCell")
        
        items = [""]
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SecondDetailTableViewCell", forIndexPath: indexPath) as! SecondDetailTableViewCell
        
        return cell
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
