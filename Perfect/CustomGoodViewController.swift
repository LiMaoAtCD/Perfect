//
//  CustomGoodViewController.swift
//  Perfect
//
//  Created by limao on 16/6/16.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class CustomGoodViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    var imagePicker: UIImagePickerController!
    var effectImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "定制"
        
        
        effectImageView = UIImageView.init()
        view.addSubview(effectImageView)
        effectImageView.image = UIImage.init(named: "customEffect")
        
        effectImageView.snp_makeConstraints { (make) in
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(effectImageView.snp_width)
            make.top.equalTo(self.snp_topLayoutGuideBottom).offset(50)
        }
        
        let helperLabel = UILabel.init()
        view.addSubview(helperLabel)
        helperLabel.text = "素材要求：1260 * 880像素"
        helperLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(effectImageView.snp_bottom).offset(50)
        }
        
        helperLabel.textColor = UIColor.blackColor()
        
        
        let uploadButton  = UIButton.init(type: .Custom)
        uploadButton.addTarget(self, action: #selector(self.uploadImage), forControlEvents: .TouchUpInside)
        
        view.addSubview(uploadButton)
        
        uploadButton.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(helperLabel.snp_bottom).offset(50)
        }
        
        uploadButton.setTitle("上传图片", forState: .Normal)
        uploadButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        uploadButton.backgroundColor = UIColor.brownColor()
        uploadButton.layer.cornerRadius = 5
        
        
        
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .SavedPhotosAlbum
        imagePicker.delegate = self
        
    }
    
    func uploadImage() {
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let size = image.size
        
        print(size)
        
        
//        1260 * 880
        if size.width * image.scale >= 1260 && size.height * image.scale >= 880 {
            picker.dismissViewControllerAnimated(true, completion: {
                self.effectImageView.image = image
            })
        } else {
            self.dismissViewControllerAnimated(true, completion: { 
                //提示素材不对
            })
        }
        
    }
    
    
    func gotoOrder() {
        
        if Util.logined {
            
        } else {
            let login = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginNavigationController") as! LoginNavigationController
            self.presentViewController(login, animated: true, completion: nil)
        
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
