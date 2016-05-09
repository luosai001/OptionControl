# OptionControl

[![CI Status](http://img.shields.io/travis/luosai/OptionControl.svg?style=flat)](https://travis-ci.org/luosai/OptionControl)
[![Version](https://img.shields.io/cocoapods/v/OptionControl.svg?style=flat)](http://cocoapods.org/pods/OptionControl)
[![License](https://img.shields.io/cocoapods/l/OptionControl.svg?style=flat)](http://cocoapods.org/pods/OptionControl)
[![Platform](https://img.shields.io/cocoapods/p/OptionControl.svg?style=flat)](http://cocoapods.org/pods/OptionControl)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

# OptionControl
OptionControl 实现多选，单选功能，纯swift编写  

    import UIKit
    import OptionControl
    class ViewController: UIViewController,SelectionControlDelegate,SelectionControlDataSource {
    
    
    var optionView :SelectionControl?
    var titles :Array<String>?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //         self.singleSelection()
        self.mutilSelection()
        //        self.datasourceDemo()
        
    }
    
    // delegate - SelectionControlDataSource
    func titlesForSeletionOptionItems(selectionControl: SelectionControl) -> Array<String> {
        return ["赞成","反对","弃权"]
    }
    
    func unseletedImageAndSeletedImage(selectionControl: SelectionControl) -> (unseletedImage: String, seletedImage: String) {
        return ("zf_unselect","zf_select")
    }
    
    
    func selectedIndexs(selectionControl: SelectionControl) -> Array<Int> {
        return [0]
    }
    
    func selectedOptionType() -> SelectionType {
        return .MutilSelectionType
    }
    
    func backgroundColorForSeletionOptionItems() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    //Demo
    func datasourceDemo(){
        optionView = SelectionControl()
        optionView!.delegate = self
        optionView!.dataSource = self
        optionView!.translatesAutoresizingMaskIntoConstraints = false ;
        self.view .addSubview(optionView!);
    }
    
    func singleSelection(){
        titles = ["赞成","反对","弃权"]
        
        optionView = SelectionControl(titles: titles!,selectedIndexs: [0],selectionType: SelectionType.SingleSelectionType,unselectedImage: "zf_unselect",selectedImage: "zf_select",backgroundColorForSeletionOptionItems: UIColor.lightGrayColor())
        optionView!.delegate = self
        optionView!.translatesAutoresizingMaskIntoConstraints = false ;
        self.view .addSubview(optionView!);
    }
    
    func mutilSelection(){
        
        titles = ["赞成","反对","弃权"]
        
        optionView = SelectionControl(titles: titles!,selectedIndexs: [0],selectionType: SelectionType.MutilSelectionType,unselectedImage: "zf_unselect",selectedImage: "zf_select",backgroundColorForSeletionOptionItems: UIColor.lightGrayColor())
        optionView!.delegate = self
        optionView!.translatesAutoresizingMaskIntoConstraints = false ;
        self.view .addSubview(optionView!);
        
    }
    
    // delegate - SelectionControlDelegate
    func selectionControl(selectionControl: SelectionControl, didSelectedOptions selecedIndexs: Array<Int>?) {
        print("\(selecedIndexs)")
    }
    // layout
    override func viewWillLayoutSubviews() {
        optionView!.removeConstraints(optionView!.constraints)
        let constHL = NSLayoutConstraint(item: optionView!, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 0)
        let constVT = NSLayoutConstraint(item: optionView!, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0)
        
        let constW = NSLayoutConstraint(item: optionView!, attribute: .Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0)
        let constH = NSLayoutConstraint(item: optionView!, attribute: .Height , relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1, constant: 0)
        
        self.view .addConstraints([constH,constHL,constVT,constW])
        
    }
    
    
}





## Requirements

## Installation

OptionControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "OptionControl"
```

## Author

luosai, luosai19910103@163.com

## License

OptionControl is available under the MIT license. See the LICENSE file for more info.
