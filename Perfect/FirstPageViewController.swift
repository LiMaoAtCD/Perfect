//
//  FirstPageViewController.swift
//  Perfect
//
//  Created by AlienLi on 16/6/14.
//  Copyright © 2016年 limao. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import SnapKit
import SDCycleScrollView

class FirstPageViewController: UIViewController, SDCycleScrollViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collection : UICollectionView!
    
    var topBanners: [FirstBannerItem]?
    var customButtons: [FirstButtonItem]?
    var goodTypes: [FirstGoodsTypeItem]?
    var goods: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.hidden = true
        fd_prefersNavigationBarHidden = true
        edgesForExtendedLayout = UIRectEdge.None

        //
        topBanners = [FirstBannerItem]()
        customButtons = [FirstButtonItem]()
        goodTypes = [FirstGoodsTypeItem]()
        goods = [String]()

        
        
        collection = UICollectionView.init(frame: view.bounds, collectionViewLayout: CollectionLayout())
        view.addSubview(collection)
        
        collection.backgroundColor = UIColor.lightGrayColor()
        collection.delegate = self
        collection.dataSource = self
    

        collection.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.registerClass(CollectionViewBannerCell.self, forCellWithReuseIdentifier: CollectionViewBannerCell.identifier)
        collection.registerClass(CollectionViewButtonsCell.self, forCellWithReuseIdentifier: CollectionViewButtonsCell.identifier)
        collection.registerClass(CollectionViewFootCell.self, forCellWithReuseIdentifier: CollectionViewFootCell.identifier)

        collection.registerClass(Header.self, forSupplementaryViewOfKind: Header.kind, withReuseIdentifier: Header.identifier)
        
        
        
         NetworkHelper.instance.request(.GET, url:  URLConstant.FirstPage.contant, parameters: nil) { [weak self](res: FirstPageResponse?) in
                self?.topBanners = res?.retObj?.topBanners
                self?.customButtons = res?.retObj?.buttons
                self?.goodTypes = res?.retObj?.types
            
            
                self?.collection.reloadData()
        }

        

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        
        } else if section == 1 {
            
            if let btns = self.customButtons {
                return btns.count
            } else {
                return 0
            }
        } else if section == 2 {
            return 1
        } else {
            if let _ = goods {
//                return goods!.count
                return 100
            } else {
                return 100
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewBannerCell.identifier, forIndexPath: indexPath) as! CollectionViewBannerCell
            
            cell.banner.clickItemOperationBlock = {
                currentIndex in
                
            }
            
            var imageUrl = [String]()
            if let _ = topBanners {
                for item in topBanners! {
                    imageUrl.append(item.imgUrl!)
                }
            }
          
            cell.banner.placeholderImage = UIImage.init(named: "h8")
            cell.banner.imageURLStringsGroup = imageUrl
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewButtonsCell.identifier, forIndexPath: indexPath) as! CollectionViewButtonsCell
            
            var buttonsUrl = [String]()
            if let _ = customButtons {
                for item in customButtons! {
                    let url = item.imgUrl!
                    buttonsUrl.append(url)
                }
            }
            
            
            cell.imageView.kf_setImageWithURL(NSURL.init(string: buttonsUrl[indexPath.row])!, placeholderImage: UIImage.init(named: "h8"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            
            
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewFootCell.identifier, forIndexPath: indexPath) as! CollectionViewFootCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionViewCell.identifier, forIndexPath: indexPath) as! CollectionViewCell
            return cell
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if indexPath.section == 3 {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(Header.kind, withReuseIdentifier: Header.identifier, forIndexPath: indexPath) as! Header
            
            var types = ["","",""]
            var selectionSection = 0
            if let _ = goodTypes where goodTypes!.count > 0 {
                
                for i in 0...goodTypes!.count - 1 {
                    types[i] = goodTypes![i].title!
                    if goodTypes![i].opened == true {
                        selectionSection = i
                    }
                }
            }
            
            
            header.segmentControl.titles = types
            header.segmentControl.currentIndex = selectionSection
            header.segmentControl.selectionHandler = { index in
                print("index: \(index)")
            }

            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSizeMake(Tool.width, 250)
        } else if indexPath.section == 1 {
            return CGSizeMake(Tool.width / 2 - 0.5, 50)
        } else if indexPath.section == 2 {
            return CGSizeMake(Tool.width, 50)
        }else {
            return CGSizeMake(Tool.width / 2 - 5, 100)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 3 {
            return CGSizeMake(Tool.width, 50)
        } else {
            return CGSizeZero
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

class CollectionLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumInteritemSpacing = 0.5
        self.minimumLineSpacing = 0.5
        if #available(iOS 9.0, *) {
            self.sectionHeadersPinToVisibleBounds = true
        } else {
            // Fallback on earlier versions
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//普通
class CollectionViewCell: UICollectionViewCell {
    static let identifier = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CollectionViewBannerCell: UICollectionViewCell {
    static let identifier = "banner"
    var banner: SDCycleScrollView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
        
        banner = SDCycleScrollView.init()
        self.addSubview(banner)
        banner.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        banner.currentPageDotColor = UIColor.whiteColor()
        
        banner.snp_makeConstraints { (make) in
            make.edges.equalTo(self).offset(UIEdgeInsetsMake(0, 0, -20, 0))
        }
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewButtonsCell: UICollectionViewCell {
    static let identifier = "button"
    
    var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellowColor()
        
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionViewFootCell: UICollectionViewCell {
    static let identifier = "foot"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
        
        let title = UILabel()
        title.text = "预览"
        title.textAlignment = .Center
        title.textColor = UIColor.whiteColor()
        self.addSubview(title)
        
        title.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




class Header: UICollectionReusableView {
    
    static let identifier = "header"
    static let kind = "UICollectionElementKindSectionHeader"
    
    var segmentControl: SegmentControlView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        segmentControl = SegmentControlView.init()
        self.addSubview(segmentControl)
        
        
        segmentControl.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SegmentControlView : UIView {
    
    var buttons:[UIButton]?
    
    var selectionHandler: (Int -> Void)?
    
    var prefixIndex: Int = 0
    var currentIndex: Int = 0 {
        willSet{
            for i in 0...2 {
                if newValue == i {
                    self.buttons?[i].setTitleColor(UIColor.whiteColor(), forState: .Normal)
                    self.buttons?[i].backgroundColor = UIColor.brownColor()
                } else {
                    self.buttons?[i].setTitleColor(UIColor.blackColor(), forState: .Normal)
                    self.buttons?[i].backgroundColor = UIColor.whiteColor()
                }
            }
        }
    }
    
    var titles:[String]? {
        willSet{
            if let _ = newValue {
                for i in 0...2 {
                    buttons?[i].setTitle(newValue![i], forState: .Normal)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buttons = [UIButton]()
        let buttonMargin: CGFloat = 10.0
        let buttonWidth = (Tool.width - 6 * buttonMargin) / 3
        
        for i in 0...2 {
            let button = UIButton.init(type: .Custom)
            button.tag = i
            self.addSubview(button)
            
            button.frame = CGRectMake(buttonMargin * ((CGFloat(i) * 2) + 1) + CGFloat(i) * buttonWidth, 3, buttonWidth, frame.size.height - 6)
            
            let leftOffset = buttonMargin * ((CGFloat(i) * 2) + 1) + CGFloat(i) * buttonWidth
            button.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(self).offset(leftOffset)
                make.top.equalTo(3)
                make.width.equalTo(buttonWidth)
                make.bottom.equalTo(-3)
            })
            
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(self.didClickItem(_:)), forControlEvents: .TouchUpInside)
            buttons?.append(button)
        }
    }
    
    func didClickItem(btn: UIButton) {
        self.currentIndex = btn.tag
        if prefixIndex != currentIndex {
            self.selectionHandler?(btn.tag)
        }
        self.prefixIndex = self.currentIndex
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


