//
//  AddressChooseViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/25.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class AddressChooseViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var pickView: UIPickerView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var items: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clearColor()
        pickView.delegate = self
        pickView.dataSource = self
        
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3, animations: { 
            self.blackView.alpha = 0.3
            }) { (_) in
                
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items!.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
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
