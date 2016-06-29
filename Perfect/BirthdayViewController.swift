//
//  BirthdayViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/29.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

protocol DateSelectionDelegate: class {
    func didselectedDate(date: String)
}


class BirthdayViewController: UIViewController{

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var sureButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: DateSelectionDelegate?
    
    var dateString: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clearColor()
        self.bgView.alpha = 0.0
        
        cancel.addTarget(self, action: #selector(self.cancelPick), forControlEvents: .TouchUpInside)
        sureButton.addTarget(self, action: #selector(self.sure), forControlEvents: .TouchUpInside)
        
        let date = NSDate()
        datePicker.setDate(date, animated: false)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateString = dateFormatter.stringFromDate(date)
    }
    
    func cancelPick() {
        self.dismissViewControllerAnimated(true) { 
        }
    }
    
    func sure() {
        let date  = self.datePicker.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateString = dateFormatter.stringFromDate(date)
        self.dismissViewControllerAnimated(true) {
           
            self.delegate?.didselectedDate(self.dateString!)
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.3, animations: { 
            self.bgView.alpha = 0.3
            }) { (_) in
                
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
