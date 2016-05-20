//
//  ViewController.swift
//  CustomPickerTest
//
//  Created by JSCON on 16/5/19.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
            UIPickerViewDataSource,
            UIPickerViewDelegate{

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var resultsLabel: UILabel!
    let dataForComponent1:[String] = ["Apple", "Banana", "Lemon", "Orange", "Peach", "Pear", "Pineapple"]
    let dataForComponent2:[String] = ["Banana", "Orange", "Pear", "Apple", "Pineapple", "Lemon", "Peach"]
    let dataForComponent3:[String] = ["Pear", "Peach", "Lemon", "Pineapple", "Apple", "Banana", "Orange"]
    
    let nameToImageMapping:[String:String] = [
        "Apple":"appleImages",
        "Banana":"bananaImages",
        "Lemon":"lemonImages",
        "Orange":"orangeImages",
        "Peach":"peachImages",
        "Pear":"pearImages",
        "Pineapple":"pineappleImages"
    ]
    
    func numberOfComponentsInPickerView(pickerView:UIPickerView) -> Int{
        return 3;
    }
    
    func pickerView(pickerView:UIPickerView,numberOfRowsInComponent component:Int) -> Int{
        if component == 0{
            return dataForComponent1.count
        } else if component == 1{
            return dataForComponent2.count
        } else {
            return dataForComponent3.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        // 获取水果名字
        var keyString:String? = nil
        
        if component == 0{
            keyString = dataForComponent1[row]
        } else if component == 1 {
            keyString = dataForComponent2[row]
        } else {
            keyString = dataForComponent3[row]
        }
        
        let imageFileName:String? = nameToImageMapping[keyString!];
        
        if view == nil{
            return UIImageView(image:UIImage(named:imageFileName!))
        }
        
        let imageView:UIImageView = view as! UIImageView
        imageView.image = UIImage(named:imageFileName!)
        
        return imageView
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 获取每个轮子中选中的水果
        let selected1 = pickerView.selectedRowInComponent(0)
        let fruit1:String! = dataForComponent1[selected1]
        
        let selected2 = pickerView.selectedRowInComponent(1)
        let fruit2:String! = dataForComponent2[selected2]
        
        let selected3 = pickerView.selectedRowInComponent(2)
        let fruit3:String! = dataForComponent3[selected3]
        
        if fruit1 == fruit2 && fruit2 == fruit3{
            resultsLabel.text = "匹配成功！"
        } else {
            resultsLabel.text = "请匹配每一行的水果"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultsLabel.text = "请匹配每一行的水果";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

