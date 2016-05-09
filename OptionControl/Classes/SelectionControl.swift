//
//  SelectionControl.swift
//  SingleSelectionControl
//
//  Created by luosai19910103@163.com on 16/4/8.
//  Copyright © 2016年 bingqingxueku. All rights reserved.
//

import UIKit

public enum SelectionType{
    case SingleSelectionType
    case MutilSelectionType
}

public protocol SelectionControlDelegate {
   func selectionControl(selectionControl:SelectionControl,didSelectedOptions selecedIndexs:Array<Int>?)
}


public protocol SelectionControlDataSource {
    
    func titlesForSeletionOptionItems( selectionControl:SelectionControl   )-> Array<String>
    
    func unseletedImageAndSeletedImage(selectionControl:SelectionControl ) ->(unseletedImage:String,seletedImage:String)
    
    func selectedIndexs(selectionControl:SelectionControl )->Array<Int>
    
    func selectedOptionType()->SelectionType
    
    func backgroundColorForSeletionOptionItems()->UIColor
}



public class SelectionControl: UIView ,SeletionOptionItemDelegate{

    var selectionType:SelectionType = .SingleSelectionType
    
   public var delegate : SelectionControlDelegate?
    
   public var dataSource : SelectionControlDataSource?
    
   public lazy var selectedIndexs :Array<Int>? = Array<Int>()
    
   public lazy var selectionOptions :NSMutableArray = {
        
        return NSMutableArray()
    }()
    

    
    func seletionOptionItemValueDidChagnge(item: SeletionOptionItem) {
        
        switch(selectionType){
        case .MutilSelectionType:
             item.selected = !item.selected!
             if self.selectedIndexs!.contains(item.tag){
                selectedIndexs!.removeAtIndex(selectedIndexs!.indexOf(item.tag)!)

             }else{
                selectedIndexs!.append(item.tag)

             }
        case .SingleSelectionType:
            
            if self.selectedIndexs!.count != 0 {
                
                let preSeletedItem = selectionOptions[selectedIndexs![0]] as! SeletionOptionItem
                preSeletedItem.selected = !preSeletedItem.selected!
                self.selectedIndexs!.removeAtIndex(0)
                
                
            }
            
             item.selected = !item.selected!
             selectedIndexs?.append(item.tag)
            
        }
        
        if let delegate = self.delegate {
            delegate.selectionControl(self, didSelectedOptions: self.selectedIndexs)
        }
    }

   
   public convenience  init(titles:Array<String>,selectedIndexs: Array<Int>?,selectionType:SelectionType?,unselectedImage:String,selectedImage:String,backgroundColorForSeletionOptionItems backgroundColor:UIColor) {
        self.init()

        var index = 0
        for title in titles {
            
            let selectionOptionItem = SeletionOptionItem(  title: title ,unselectedImage: unselectedImage, selectedImage:selectedImage )
            selectionOptionItem.backgroundColor = backgroundColor
            selectionOptionItem.delegate = self
            selectionOptions.addObject(selectionOptionItem)
            self.addSubview(selectionOptionItem)
            selectionOptionItem.tag = index
            index += 1
        
        }
        
        
        if selectionType != nil {
            
            self.selectionType = selectionType!
            
            if let selectedIndexs = selectedIndexs {
                self.selectedIndexs = selectedIndexs

                switch self.selectionType{
                case .SingleSelectionType :
                    let selectionOptionItem = self.selectionOptions[0] as! SeletionOptionItem
                    selectionOptionItem.selected = true
                    break
                    
                case .MutilSelectionType:
                    var index = 0
                    for _ in self.selectedIndexs!{
                        
                        let selectionOptionItem = self.selectionOptions[index] as! SeletionOptionItem
                        selectionOptionItem.selected = true
                        index += 1
                        
                    }
                }
  
            }
           
        }
        
        
        
    }



    
    override public func willMoveToSuperview(newSuperview: UIView?) {
        
        if let  _ = self.dataSource{
            let titles = dataSource!.titlesForSeletionOptionItems(self)
            let (unselectedImage,selectedImage) = dataSource!.unseletedImageAndSeletedImage(self)
            self.selectionType = dataSource!.selectedOptionType()
            self.selectedIndexs = dataSource!.selectedIndexs(self)
            let backgroudColor = dataSource!.backgroundColorForSeletionOptionItems()
            var index = 0
            for title in titles {
                
                let selectionOptionItem = SeletionOptionItem()
                selectionOptionItem.titleLable!.text = title
                selectionOptionItem.unselectedImage = unselectedImage
                selectionOptionItem.selectedImage = selectedImage
                selectionOptionItem.backgroundColor = backgroudColor

                selectionOptionItem.delegate = self
                selectionOptions.addObject(selectionOptionItem)
                self.addSubview(selectionOptionItem)
                selectionOptionItem.tag = index
                index += 1
                
            }
            
            
            if let selectedIndexs = selectedIndexs {
                self.selectedIndexs = selectedIndexs
                
                switch self.selectionType{
                case .SingleSelectionType :
                    let selectionOptionItem = self.selectionOptions[0] as! SeletionOptionItem
                    selectionOptionItem.selected = true
                    break
                    
                case .MutilSelectionType:
                    var index = 0
                    for _ in self.selectedIndexs!{
                        
                        let selectionOptionItem = self.selectionOptions[index] as! SeletionOptionItem
                        selectionOptionItem.selected = true
                        index += 1
                        
                    }
                }
            }
            

        }
        
    }
    
    
    
    
    override public func layoutSubviews() {
        
        
        
       let views = self.subviews
        
        let superView = self
        var index = 0
        let Height:CGFloat = 40.0
        let parding:CGFloat = 5.0
        for view in views {
            
            view.removeConstraints(view.constraints)
            
            let ConstsY = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: superView, attribute: .Top, multiplier: 1, constant: CGFloat(index)*(parding+Height)+parding)
            let ConstsX = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: superView, attribute: .Leading, multiplier: 1, constant: 0)
            
            let ConstsW = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: superView, attribute: .Width, multiplier: 1, constant: 0)
            
            let ConstsH = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0, constant: Height)
            
            superView.addConstraints([ConstsY,ConstsX,ConstsW])
            view.addConstraint(ConstsH)
            
            index += 1
        }
        
    }
    
    
  
}
