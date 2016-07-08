//
//  AddressChooseViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/25.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import RealmSwift
class AddressChooseViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var pickView: UIPickerView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var items: [String]?
    
    var provinces: [ProviceItem]?
    var citys: [CityItem]?
    var countys: [CountyItem]?
    
    var selectionCityRow: Int = 0
    var selectionProvinceRow: Int = 0
    var selectionCountyRow: Int = 0
    
    var areaID: Int64 = 0
    var addressString: String?
    
    var handler: ((Int64, String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clearColor()
        self.blackView.alpha = 0.0
        pickView.delegate = self
        pickView.dataSource = self
        
        let realm = try! Realm()
        
        
        provinces = [ProviceItem]()
        citys = [CityItem]()
        countys = [CountyItem]()
        
        let Provinces = realm.objects(ProviceItem)
        provinces?.appendContentsOf(Provinces)
        
        let cityitems = provinces![selectionCityRow].c
        citys?.appendContentsOf(cityitems)
        
        let countyItems = citys![selectionCountyRow].c
        countys?.appendContentsOf(countyItems)
        
        sureButton.addTarget(self, action: #selector(self.sure), forControlEvents: .TouchUpInside)
        cancelButton.addTarget(self, action: #selector(self.cancel), forControlEvents: .TouchUpInside)
    }
    
    func sure() {
        self.handler?(areaID, addressString)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3, animations: { 
            self.blackView.alpha = 0.3
            }) { (_) in
                self.pickView.reloadComponent(0)
                self.pickerView(self.pickView, didSelectRow: 0, inComponent: 0)
                
                self.pickView.reloadComponent(1)
                self.pickerView(self.pickView, didSelectRow: 0, inComponent: 1)
                self.pickView.selectRow(0, inComponent: 1, animated: false)
                
                self.pickView.reloadComponent(2)
                self.pickerView(self.pickView, didSelectRow: 0, inComponent: 2)
                self.pickView.selectRow(0, inComponent: 2, animated: false)
                
                
                
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return provinces!.count
        } else if component == 1{
            return citys!.count
        } else {
            return countys!.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return provinces![row].n ?? " "
        } else if component == 1 {
            return citys![row].n ?? " "
        } else {
            return countys![row].n ?? " "
        }
        
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectionProvinceRow = row

            citys?.removeAll()
            let cityitems = provinces![row].c
            citys?.appendContentsOf(cityitems)
            pickerView.reloadComponent(component + 1)
            self.pickerView(pickerView, didSelectRow: 0, inComponent: component + 1)
            pickerView.selectRow(0, inComponent: component + 1, animated: true)
            
        } else if component == 1 {
            selectionCityRow = row

            countys?.removeAll()
            if citys!.count > row {
                let countyItems = citys![row].c
                countys?.appendContentsOf(countyItems)
                pickerView.reloadComponent(component + 1)
                self.pickerView(pickerView, didSelectRow: 0, inComponent: component + 1)
                pickerView.selectRow(0, inComponent: component + 1, animated: true)
                
                if countys!.isEmpty {
                    addressString = provinces![selectionProvinceRow].n! + citys![selectionCityRow].n!
                    areaID = citys![selectionCityRow].i
                }
            } else {
                
            }
        
        } else {
            selectionCountyRow = row
            if countys!.isEmpty {
            } else {
                
                if countys!.count > row {
                    addressString = provinces![selectionProvinceRow].n! + citys![selectionCityRow].n! + countys![row].n!
                    areaID = countys![selectionCountyRow].i
                }
               
            }
            
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
