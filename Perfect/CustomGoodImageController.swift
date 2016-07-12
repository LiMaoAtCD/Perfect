//
//  CustomGoodImageController.swift
//  Perfect
//
//  Created by limao on 16/7/12.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import SVProgressHUD

class CustomGoodImageController: BaseViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    var completeHandler: ((Int64, UIImage) -> Void)?

    var backGroundImageView: UIImageView!
    var addImageButton: UIButton!
    var confirmButton: UIButton!
    var contentImageView: UIImageView!
    var navi_back: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    var image: UIImage? {
        willSet {
            if let image = newValue {
                self.imageRatio = image.size.height / image.size.width
                print(self.imageRatio)
                self.contentImageView.image = image
                contentImageView.snp_remakeConstraints { (make) in
                    make.left.equalTo(115.pixelToPoint)
                    make.top.equalTo(186.pixelToPoint)
                    make.centerX.equalTo(view)
                    make.height.equalTo(contentImageView.snp_width).multipliedBy(self.imageRatio)
                }
            }
        }
    }
    
    var imageRatio: CGFloat = 1.0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fd_prefersNavigationBarHidden = true
        configureViews()
        
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .SavedPhotosAlbum
        imagePicker.delegate = self
        
        self.image = UIImage.init(named: "custom_image_placeholder")
        
    }
    
    func configureViews() {
        backGroundImageView = UIImageView.init(image: UIImage.init(named: "custom_gird_back")!)
        view.addSubview(backGroundImageView)
        backGroundImageView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        confirmButton = UIButton.init(type: .Custom)
        confirmButton.setBackgroundImage(UIImage.init(named: "custom_image_confirm_0"), forState: .Normal)
        confirmButton.setBackgroundImage(UIImage.init(named: "custom_image_confirm_1"), forState: .Highlighted)
        confirmButton.setTitle("确认图片", forState: .Normal)
        view.addSubview(confirmButton)
        confirmButton.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(110.pixelToPoint)
        }
        confirmButton.addTarget(self, action: #selector(self.confirmImage), forControlEvents: .TouchUpInside)
        
        contentImageView = UIImageView()
        view.addSubview(contentImageView)
        contentImageView.snp_remakeConstraints { (make) in
            make.left.equalTo(115.pixelToPoint)
            make.top.equalTo(186.pixelToPoint)
            make.centerX.equalTo(view)
            make.height.equalTo(contentImageView.snp_width).multipliedBy(self.imageRatio)
        }
        
        addImageButton = UIButton.init(type: .Custom)
        view.addSubview(addImageButton)
        addImageButton.snp_makeConstraints { (make) in
            make.width.height.equalTo(48.pixelToPoint)
            make.bottom.equalTo(confirmButton.snp_top).offset(-110.pixelToPoint)
            make.centerX.equalTo(view)
        }
        addImageButton.addTarget(self, action: #selector(self.chooseImage), forControlEvents: .TouchUpInside)
        
        addImageButton.setImage(UIImage.init(named: "cutstom_image_add"), forState: .Normal)
        
        
        navi_back = UIButton.init(type: .Custom)
        navi_back.setImage(UIImage.init(named: "custom_image_back"), forState: .Normal)
        navi_back.addTarget(self, action: #selector(self.pop), forControlEvents: .TouchUpInside)
        view.addSubview(navi_back)
        navi_back.snp_makeConstraints { (make) in
            make.left.equalTo(36.pixelToPoint)
            make.top.equalTo(50.pixelToPoint)
            make.width.equalTo(168.pixelToPoint)
            make.height.equalTo(80.pixelToPoint)
        }
        
    }
    
    
    
    func chooseImage() {
        self.presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    func confirmImage() {
        
        SVProgressHUD.showWithStatus("正在上传")
        NetworkHelper.instance.uploadImage(self.image!, forType: ["category": "custwine"], completion: { (result: UploadImageResponse?) in
            self.completeHandler?(result!.retObj!.imgId, self.image!)
            SVProgressHUD.dismiss()
            self.navigationController?.popViewControllerAnimated(true)
            }, failed: { (msg, code) in
                SVProgressHUD.showErrorWithStatus(msg)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.contentImageView.image = image
        self.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    


}
