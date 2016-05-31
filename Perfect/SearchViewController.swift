//
//  SearchViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/30.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {

    var searchBar: UISearchBar!
    var tableView: UITableView!
    var results: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        
        searchBar = UISearchBar.init()
        searchBar.showsCancelButton = true
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        searchBar.setCancelButtonTitle("取消")
        searchBar.tintColor = UIColor.greenColor()
        let searchField = searchBar.valueForKey("searchField") as! UITextField
        searchField.tintColor = UIColor.redColor()
        
        
        tableView = UITableView.init(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(ResultCell.self, forCellReuseIdentifier: "Cell")
        
        
        results = [String]()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        results.append(searchBar.text!)
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detail = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SecondDetailViewController") as! SecondDetailViewController
        detail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        searchBar.text = ""
        searchBar.becomeFirstResponder()
    }
    
    
    
}

class ResultCell: UITableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UISearchBar {
    func setCancelButtonTitle(title: String) {
        if #available(iOS 9.0, *) {
            UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).title = title
        } else {
            UIBarButtonItem.appearanceWhenContainedWithin(UISearchBar.self).title = title
        }
    }
    
    func setTextColor(textColor: UIColor) {
        if #available(iOS 9.0, *) {
            UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).textColor = textColor
        } else {
            UITextField.appearanceWhenContainedWithin(UISearchBar.self).textColor = textColor
        }
    }
}
