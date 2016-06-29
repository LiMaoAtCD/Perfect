//
//  CMProfileGenderViewController.swift
//  covermedia
//
//  Created by AlienLi on 16/2/17.
//  Copyright © 2016年 covermedia. All rights reserved.
//

import UIKit


enum Gender {
    case Male
    case Female
    case None
}

protocol GenderSelectionDelegate: class {
    func didSelectedGenderType(type: Gender)
}


class CMProfileGenderViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var firstItemView: UIView!
    @IBOutlet weak var firstItemLabel: UILabel!
    
    @IBOutlet weak var secondItemView: UIView!
    @IBOutlet weak var secondItemLabel: UILabel!
    
    @IBOutlet weak var cancelItemView: UIView!
    @IBOutlet weak var cancelItemLabel: UILabel!
    
    weak var delegate: GenderSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSubViews()
    }
    
    func setupSubViews() {
        self.bgView.alpha = 0.0
        
        let tapFirstGesture = UITapGestureRecognizer(target: self, action: #selector(CMProfileGenderViewController.selectionFirstItem))
        
        self.firstItemView.addGestureRecognizer(tapFirstGesture)
        
        let tapSecondGesture = UITapGestureRecognizer(target: self, action: #selector(CMProfileGenderViewController.selectionSecondItem))
        
        self.secondItemView.addGestureRecognizer(tapSecondGesture)
        
        let tapThirdGesture = UITapGestureRecognizer(target: self, action: #selector(CMProfileGenderViewController.selectionCancelItem))
        
        self.cancelItemView.addGestureRecognizer(tapThirdGesture)
        
        let tapBgGesture = UITapGestureRecognizer(target: self, action: #selector(CMProfileGenderViewController.selectionCancelItem))

        
        bgView.addGestureRecognizer(tapBgGesture)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.bgView.alpha = 0.3
            }) { (finished) -> Void in
                
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        bgView.alpha = 0.0
    }

    
    func selectionFirstItem() {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didSelectedGenderType(.Male)
        }
    }
    
    func selectionSecondItem() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didSelectedGenderType(.Female)
        }
    }
    
    func selectionCancelItem() {
        self.dismissViewControllerAnimated(true) { () -> Void in
            self.delegate?.didSelectedGenderType(.None)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
