//
//  FirstTableViewController.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SDCycleScrollView
class FirstTableViewController: UITableViewController {
    
    class func viewController() -> FirstTableViewController {
        let viewController =  UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FirstTableViewController") as! FirstTableViewController
        return viewController
    }

    let imageURLs = ["https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg", "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                     "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                     ]
    let titles = ["1", "2", "3", "4"]
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(FirstBannerCell.self, forCellReuseIdentifier: FirstBannerCell.identifier)
        tableView.registerClass(FirstNormalCell.self, forCellReuseIdentifier: FirstNormalCell.identifier)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(FirstBannerCell.identifier, forIndexPath: indexPath) as! FirstBannerCell
            cell.banner.clickItemOperationBlock = {
               [weak self] currentIndex in
                self?.gotoDetail()
            }
            cell.banner.imageURLStringsGroup = imageURLs
            cell.banner.titlesGroup = titles
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(FirstNormalCell.identifier, forIndexPath: indexPath) as! FirstNormalCell
            
            
            return cell
        }
    }
    
    func gotoDetail() {
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return 200
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
