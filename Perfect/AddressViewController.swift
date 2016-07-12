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
    
    var selectedHandler: (AddressItemsEntity -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "收货地址管理"
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
        tableView.separatorStyle = .None
        tableView.registerClass(AddressTableViewCell.self, forCellReuseIdentifier: "address")
        tableView.backgroundColor = UIColor.globalBackGroundColor()
        
        
        
        let footer = UIView.init(frame: CGRectMake(0, 0, Tool.width, 50))
        view.addSubview(footer)
        footer.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(50)
        }
        footer.backgroundColor = UIColor.globalRedColor()
        
        let addAddressButon = UIButton.init(type: .Custom)
        addAddressButon.setTitle("添加新地址", forState: .Normal)
        addAddressButon.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addAddressButon.setBackgroundImage(UIImage.init(named: "address_add_0"), forState: .Normal)
        addAddressButon.setBackgroundImage(UIImage.init(named: "address_add_1"), forState: .Highlighted)

        footer.addSubview(addAddressButon)
        
        addAddressButon.addTarget(self, action: #selector(self.addAddress), forControlEvents: .TouchUpInside)
        addAddressButon.snp_makeConstraints { (make) in
            make.left.equalTo(footer)
            make.right.equalTo(footer)
            make.height.equalTo(50)
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
                
                let addresses = realm.objects(AddressItemsEntity)
                try! realm.write({
                    realm.delete(addresses)
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
        
        cell.defaultAddress.clickHandler = { [weak self](id, isDefault) in
            
            //MARK: 设为默认
//            
//            var params = [String:AnyObject]()
//            params["id"] = NSNumber.init(longLong: id)
//            params["name"] = self?.addressItems[indexPath.row].contactName
//            params["phone"] =  self?.addressItems[indexPath.row].contactPhone
//            params["address"] = self?.addressItems[indexPath.row].contactAddress
//            params["areaId"] = NSNumber.init(longLong:  self!.addressItems[indexPath.row].areaId)
//            params["isDefault"] = isDefault
//
//            NetworkHelper.instance.request(.GET, url: URLConstant.saveOrUpdateLoginMemberDeliveryAddress.contant, parameters: params, completion: { (result: DataResponse?) in
//                let realm = try! Realm()
//                let addresses = realm.objects(AddressItemsEntity)
//                if !addresses.isEmpty {
//                    
//                    for address in addresses {
//                        if address.id == id {
//                            try! realm.write({
//                                address.isDefault = true
//                            })
//                        } else {
//                            try! realm.write({
//                                address.isDefault = false
//                            })
//                        }
//                    }
//                }
//                
//                self?.tableView.reloadData()
//
//            }) { (errormsg, errcode) in
//                SVProgressHUD.showErrorWithStatus(errormsg ?? "地址修改失败")
//            }

            var defaultString = ""
            if isDefault {
                defaultString = "true"
            } else {
                defaultString = "false"
            }
            
            SVProgressHUD.show()
            NetworkHelper.instance.request(.GET, url: URLConstant.setLoginMemberDefaultDeliveryAddress.contant, parameters: ["id": NSNumber.init(longLong: id),"isDefault": defaultString], completion: { (result: DataResponse?) in
                    SVProgressHUD.dismiss()
                    let realm = try! Realm()
                    let addresses = realm.objects(AddressItemsEntity)
                    if !addresses.isEmpty {
                        
                        for address in addresses {
                            if address.id == id && isDefault {
                                try! realm.write({
                                    address.isDefault = true
                                })
                            } else {
                                try! realm.write({
                                    address.isDefault = false
                                })
                            }
                        }
                    }
                self?.addressItems.removeAll()
                if !addresses.isEmpty {
                    self?.addressItems.appendContentsOf(addresses)
                }
                self?.tableView.reloadData()
                
                }, failed: { (msg, code) in
                    SVProgressHUD.showErrorWithStatus(msg ?? "操作失败")
            })
        }
        
        cell.editView.clickHandler = { [weak self](id, isDefault) in
            
            let edit = AddressEditViewController.init(nibName: "AddressEditViewController", bundle: nil)
            edit.entity = self?.addressItems?[indexPath.row]
            self?.navigationController?.pushViewController(edit, animated: true)
        }
        cell.deleteView.clickHandler = { [weak self](id, isDefault) in
            
            self?.alertDeleteAddress(id, isDefault: isDefault)
        }
        

        return cell
    }
    
    func alertDeleteAddress(id: Int64, isDefault: Bool) {
        
        let alertController = UIAlertController.init(title: "", message: "确认删除收获地址？", preferredStyle: .Alert)
        
        let sureAction = UIAlertAction.init(title: "确认", style: .Default) { (_) in
            SVProgressHUD.show()
            NetworkHelper.instance.request(.GET, url: URLConstant.deleteLoginMemberDeliveryAddress.contant, parameters: ["id": NSNumber.init(longLong: id),"isDefault": isDefault], completion: { [weak self](result: DataResponse?) in
                SVProgressHUD.dismiss()
                self?.addressItems.removeAll()
                let realm = try! Realm()
                let toDeleteaddresses = realm.objects(AddressItemsEntity).filter("id == \(id)")
                if !toDeleteaddresses.isEmpty {
                    try! realm.write({
                        realm.delete(toDeleteaddresses)
                    })
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
        
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Default) { (_) in
            
        }
        
        alertController.addAction(sureAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let _ = self.selectedHandler {
            self.selectedHandler!(addressItems[indexPath.row])
            self.navigationController?.popViewControllerAnimated(true)
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
