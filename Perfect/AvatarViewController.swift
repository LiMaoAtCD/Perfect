//
//  AvatarViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/21.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit

class AvatarViewController: BaseViewController {

    var backgroundView: UIView!
    var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(hexString:"#dbdbdb")
        self.view.addSubview(backgroundView)
        backgroundView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        backgroundView.alpha = 0.0
        
        mainView = UIView()
        mainView.clipsToBounds = true
        self.view.addSubview(mainView)
        mainView.snp_makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(150)
        }
        mainView.backgroundColor = UIColor.whiteColor()
        mainView.layer.cornerRadius = 10.0
        
        
        let titleView = UIView()
        titleView.backgroundColor = UIColor.globalBackGroundColor()
        mainView.addSubview(titleView)
        titleView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(mainView)
            make.height.equalTo(mainView.snp_height).multipliedBy(0.33)
        }
        
        let titleLabel = UILabel()
        titleView.addSubview(titleLabel)
        titleLabel.text = "修改头像"
        titleLabel.textColor = UIColor.init(hexString:"#333333")
        titleLabel.font = UIFont.systemFontOfSize(18)
        titleLabel.snp_makeConstraints { (make) in
            make.center.equalTo(titleView)
        }
        
        let centerView = UIView()
        mainView.addSubview(centerView)
        centerView.snp_makeConstraints { (make) in
            make.left.right.equalTo(mainView)
            make.top.equalTo(titleView.snp_bottom)
            make.height.equalTo(mainView.snp_height).multipliedBy(0.33)
        }
        
        let tapCamera = UITapGestureRecognizer.init(target: self, action: #selector(self.camera))
        centerView.addGestureRecognizer(tapCamera)

        
        let cameraImageview = UIImageView()
        centerView.addSubview(cameraImageview)
        cameraImageview.image = UIImage.init(named: "me_camera")
        cameraImageview.snp_makeConstraints { (make) in
            make.height.width.equalTo(40.pixelToPoint)
            make.centerY.equalTo(centerView)
            make.left.equalTo(40.pixelToPoint)
        }
        
        let cameraTitle = UILabel()
        centerView.addSubview(cameraTitle)
        cameraTitle.snp_makeConstraints { (make) in
            make.left.equalTo(cameraImageview.snp_right).offset(14)
            make.centerY.equalTo(cameraImageview)
        }
        cameraTitle.textColor = UIColor.init(hexString:"#333333")
        cameraTitle.text = "拍照上传"
        cameraTitle.font = UIFont.systemFontOfSize(15)
        
        
        
        let bottomView = UIView()
        mainView.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(mainView)
            make.height.equalTo(mainView.snp_height).multipliedBy(0.33)
        }
        
        let tapLocal = UITapGestureRecognizer.init(target: self, action: #selector(self.library))
        bottomView.addGestureRecognizer(tapLocal)

        
        let photolibraryImageview = UIImageView()
        photolibraryImageview.image = UIImage.init(named: "me_album")
        bottomView.addSubview(photolibraryImageview)
        photolibraryImageview.snp_makeConstraints { (make) in
            make.height.width.equalTo(40.pixelToPoint)
            make.centerY.equalTo(bottomView)
            make.left.equalTo(40.pixelToPoint)
        }
        
        let libraryLabel = UILabel()
        bottomView.addSubview(libraryLabel)
        libraryLabel.snp_makeConstraints { (make) in
            make.left.equalTo(photolibraryImageview.snp_right).offset(14)
            make.centerY.equalTo(photolibraryImageview)
        }
        libraryLabel.textColor = UIColor.init(hexString:"#333333")
        libraryLabel.text = "本地上传"
        libraryLabel.font = UIFont.systemFontOfSize(15)
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGrayColor()
        mainView.addSubview(line)
        line.snp_makeConstraints { (make) in
            make.left.right.equalTo(mainView)
            make.height.equalTo(0.3)
            make.bottom.equalTo(centerView)
        }
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.dismiss))
        self.view.addGestureRecognizer(tap)
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    func camera() {
        
    }
    
    func library() {
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.3, animations: { 
            self.backgroundView.alpha = 0.5
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
