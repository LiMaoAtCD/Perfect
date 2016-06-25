//
//  AddressViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/5/28.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
import SVProgressHUD

class AddressViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate {

    
    var tableView: UITableView!
    var addressItems: [AddressItemsEntity]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addressItems = [AddressItemsEntity]()
        let realm = try! Realm()
        let addresses = realm.objects(AddressItemsEntity)
        if !addresses.isEmpty {
            addressItems.appendContentsOf(addresses)
        }
        
        tableView = UITableView.init(frame: view.bounds, style: .Plain)
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.snp_topLayoutGuideBottom)
            make.bottom.equalTo(view.snp_bottom).offset(-50)
        }
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.tableFooterView = UIView()
        tableView.registerClass(AddressTableViewCell.self, forCellReuseIdentifier: "address")
        tableView.backgroundColor = UIColor(hexString: "#cccccc")
        
        
        
        let footer = UIView.init(frame: CGRectMake(0, 0, Tool.width, 50))
        view.addSubview(footer)
        footer.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(50)
        }
        footer.backgroundColor = UIColor.redColor()
        
        let addAddressButon = UIButton.init(type: .Custom)
        addAddressButon.setTitle("添加新地址", forState: .Normal)
        addAddressButon.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        footer.addSubview(addAddressButon)
        
        addAddressButon.addTarget(self, action: #selector(self.addAddress), forControlEvents: .TouchUpInside)
        addAddressButon.snp_makeConstraints { (make) in
            make.left.equalTo(footer)
            make.right.equalTo(footer)
            make.height.equalTo(40)
            make.center.equalTo(footer)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NetworkHelper.instance.request(.GET, url: URLConstant.getLoginMemberDeliveryAddresses.contant, parameters: nil, completion: { (result: AddressResponse?) in
            
            let addresses = result?.retObj?.addresses
            var temps = [AddressItemsEntity]()
            if let _ = addresses {
                
                temps.appendContentsOf(addresses!)
                let realm = try! Realm()

                try! realm.write({
                    realm.add(temps, update: true)
                })
            }
            
            self.addressItems.removeAll()
            self.addressItems.appendContentsOf(temps)
            
            self.tableView.reloadData()
            
        }) { (errorMsg: String?, errorCode: Int) in
            print(errorMsg ?? "")
        }

    }
    
    func addAddress() {
        let edit = AddressEditViewController.init(nibName: "AddressEditViewController", bundle: nil)
        self.navigationController?.pushViewController(edit, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("address", forIndexPath: indexPath) as! AddressTableViewCell
        cell.entity = addressItems[indexPath.row]
        
        cell.defaultAddress.clickHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        
        cell.editView.clickHandler = { [weak self](id, isDefault) in
            
            let edit = AddressEditViewController.init(nibName: "AddressEditViewController", bundle: nil)
            self?.navigationController?.pushViewController(edit, animated: true)
        }
        cell.deleteView.clickHandler = { [weak self](id, isDefault) in
            NetworkHelper.instance.request(.GET, url: URLConstant.deleteLoginMemberDeliveryAddress.contant, parameters: ["id": NSNumber.init(longLong: id),"isDefault": isDefault], completion: { [weak self](result: DataResponse?) in
                
                self?.addressItems.removeAll()
                let realm = try! Realm()
                let toDeleteaddresses = realm.objects(AddressItemsEntity).filter("id == \(id)")
                if !toDeleteaddresses.isEmpty {
                    realm.delete(toDeleteaddresses.first!)
                }
                let addresses = realm.objects(AddressItemsEntity)
                if !addresses.isEmpty {
                    self?.addressItems.appendContentsOf(addresses)
                }
                self?.tableView.reloadData()
                
                }, failed: { (errmsg: String?, errcode: Int) in
                    SVProgressHUD.showErrorWithStatus(errmsg ?? "操作失败")
            })
        }
        

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
