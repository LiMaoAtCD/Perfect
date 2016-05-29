//
//  FirstTableViewController.swift
//  Perfect
//
//  Created by limao on 16/5/27.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SDCycleScrollView
import Kingfisher
class FirstTableViewController: UITableViewController {
    
    class func viewController() -> FirstTableViewController {
        let viewController =  UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FirstTableViewController") as! FirstTableViewController
        return viewController
    }
    
    var imageURLs: [String]?
    var titles: [String]?
    var itemImageURLs: [String]?
    
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
            return itemImageURLs!.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Configure the cell...
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(FirstBannerCell.identifier, forIndexPath: indexPath) as! FirstBannerCell
            cell.banner.clickItemOperationBlock = {
               [weak self] currentIndex in
                self?.gotoDetail(currentIndex)
            }
            cell.banner.imageURLStringsGroup = imageURLs
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(FirstNormalCell.identifier, forIndexPath: indexPath) as! FirstNormalCell
            cell.contentImageView?.kf_setImageWithURL(NSURL.init(string: itemImageURLs![indexPath.row])!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            return cell
        }
    }
    
    func gotoDetail(index: Int) {
        let detail = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FirstDetailViewController") as! FirstDetailViewController
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section != 0 {
            
            let detail = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FirstDetailViewController") as! FirstDetailViewController
            detail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detail, animated: true)
        }
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
