//
//  RegisterTypeViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/29.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit


protocol TypeSelectionDelegate: class {
    func didselectedIndex(index: Int)
}

class RegisterTypeViewController: UIViewController {

    
    @IBOutlet weak var bgVIew: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var personView: UIView!
    
    @IBOutlet weak var companyView: UIView!
    
    @IBOutlet weak var cancelView: UIView!
    
    weak var delegate: TypeSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bgVIew.alpha = 0.0
        self.view.backgroundColor = UIColor.clearColor()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.didSelectItem(_:)))
        personView.addGestureRecognizer(tap)
        personView.tag = 0

        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(self.didSelectItem(_:)))
        companyView.addGestureRecognizer(tap1)
        companyView.tag = 1
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(self.didSelectItem(_:)))
        cancelView.addGestureRecognizer(tap2)
        cancelView.tag = 2
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animateWithDuration(0.3, animations: { 
            self.bgVIew.alpha = 0.3
            }) { (_) in
                
        }
    }
    
    func didSelectItem(tap: UITapGestureRecognizer) {
        self.bgVIew.alpha = 0.0
        self.dismissViewControllerAnimated(true) { 
            self.delegate?.didselectedIndex(tap.view!.tag)
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
