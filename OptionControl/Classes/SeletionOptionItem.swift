//
//  SeletionOptionItem.swift
//  SingleSelectionControl
//
//  Created by luosai19910103@163.com on 16/4/8.
//  Copyright © 2016年 bingqingxueku. All rights reserved.
//

import UIKit

protocol SeletionOptionItemDelegate{
    func seletionOptionItemValueDidChagnge(item :SeletionOptionItem)->Void
}


class SeletionOptionItem: UIView,UIGestureRecognizerDelegate {

     var delegate :SeletionOptionItemDelegate?
    
     lazy var imageView: UIImageView? = {
        
        let imageView = UIImageView()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SeletionOptionItem.tapGestureRecognizer(_:)))
        tapGestureRecognizer.delegate = self
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.userInteractionEnabled = true 
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy  var titleLable: UILabel? = {
        
        let lable = UILabel()
        self.addSubview(lable)
        return lable
        
    }()
    
    var selected :Bool? = false{
        
        willSet{
            
            if  (newValue != nil) && newValue!.boolValue == true {
                
                self.imageView!.image = UIImage(named: selectedImage!)
            }else{
                self.imageView!.image = UIImage(named: unselectedImage!)

            }
        
        }
      
    }
    
    var selectedImage :String?
    var unselectedImage :String?

     convenience init(title:String,unselectedImage:String,selectedImage :String) {
        self.init()
        
        self.backgroundColor = UIColor.lightGrayColor()

        self.unselectedImage = unselectedImage

        self.selectedImage = selectedImage
        self.titleLable!.text = title
        self.imageView!.image = UIImage(named: unselectedImage)


        
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        self.imageView!.translatesAutoresizingMaskIntoConstraints = false
        self.titleLable!.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func tapGestureRecognizer(tapGestureRecognizer:UITapGestureRecognizer){
        
        if let delegate = self.delegate {
            delegate.seletionOptionItemValueDidChagnge(self)
        }
    }
 

    override func layoutSubviews() {
        

        let superView = self
        
        let views = self.subviews
        
        let imageH:CGFloat = 18.0
        let imageRightToLable :CGFloat = -10
        let titleLableWidth :CGFloat = 100
        
        let titleLableHight :CGFloat = 30
        
        for view in views {
            
            view.removeConstraints(view.constraints)
            
            if (view === self.imageView){
                
                
                let imageConstY = NSLayoutConstraint(item: self.imageView!, attribute: .CenterY, relatedBy: .Equal, toItem: superView, attribute: .CenterY, multiplier: 1, constant: 0)
                
                let imageConstXL = NSLayoutConstraint(item: imageView!, attribute:.Leading, relatedBy: .Equal, toItem: superView, attribute: .Leading, multiplier: 1, constant: 10)
                
                let imageConstXR = NSLayoutConstraint(item: imageView!, attribute: .Trailing, relatedBy: .Equal, toItem: self.titleLable!, attribute: .Leading, multiplier: 1, constant: imageRightToLable)
                
                let imageConstW = NSLayoutConstraint(item: imageView!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute , multiplier: 0, constant: imageH)
                
                let ImageConstH = NSLayoutConstraint(item: imageView!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: imageH)
                
                
                superView.addConstraints([imageConstY,imageConstXL,imageConstXR])
                self.imageView!.addConstraints([imageConstW,ImageConstH])
                
            }else if (view === self.titleLable){
                
                let titleConstYC = NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: superView, attribute: .CenterY, multiplier: 1, constant: 0)
                
                let titleConstXL = NSLayoutConstraint(item:view
                    , attribute: .Leading, relatedBy: .Equal, toItem: self.imageView!, attribute: .Trailing, multiplier: 1, constant: -imageRightToLable)
                let titleConstW = NSLayoutConstraint(item: view ,attribute: .Width
                    , relatedBy: .Equal, toItem:nil, attribute:.NotAnAttribute, multiplier: 0, constant: titleLableWidth)
                let titleConstH = NSLayoutConstraint(item: view ,attribute: .Height
                    , relatedBy: .Equal, toItem:nil, attribute:.NotAnAttribute, multiplier: 0, constant:titleLableHight)
                
                self.addConstraints([titleConstYC,titleConstXL])
                self.titleLable!.addConstraints([titleConstW,titleConstH])
                
            }
            
            
        }


  }

}
