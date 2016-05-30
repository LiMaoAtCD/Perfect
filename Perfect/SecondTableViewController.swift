//
//  SecondTableViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class SecondTableViewController: UITableViewController, UISearchBarDelegate {

    
    var searchBar: UISearchBar!
    
    var items: [[String: String]]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        items = [
            ["title": "学习定制","content": "30秒学会定制","date":"2016-05-01"],
            ["title": "系统公告","content": "新掌柜俗称指南","date":"2016-05-01"],
            ["title": "促销通知","content": "各种优惠","date":"2016-05-03"]]
        
        self.tableView.registerClass(SecondInfoCell.self, forCellReuseIdentifier: SecondInfoCell.identifier)
        
        searchBar = UISearchBar.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 50))
        searchBar.delegate = self
        searchBar.placeholder = "搜索"
        self.tableView.tableHeaderView = searchBar
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60


    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        
        
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SecondInfoCell.identifier, forIndexPath: indexPath) as! SecondInfoCell

        // Configure the cell...
        cell.titleLabel.text = items[indexPath.row]["title"]
        cell.contentLabel.text = items[indexPath.row]["content"]
        cell.dateLabel.text = items[indexPath.row]["date"]


        return cell
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
