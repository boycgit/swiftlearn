//
//  ViewController.swift
//  ActionSheetSample
//
//  Created by JSCON on 16/5/14.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func onPresentActionSheet(sender: AnyObject) {
        
        let alert = UIAlertController(title: "This is the title", message: "This is the message", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Destructive", style: UIAlertActionStyle.Destructive, handler: nil))
        
//        let alert = UIAlertController(title: "更改背景颜色",
//                                message: "选择一种颜色",
//                                preferredStyle:UIAlertControllerStyle.ActionSheet);
//        alert.addAction(UIAlertAction(title:"红色",
//            style:UIAlertActionStyle.Default,
//            handler:{
//                (action:UIAlertAction) -> Void in
//                self.view.backgroundColor = UIColor.redColor()
//        }))
//        alert.addAction(UIAlertAction(title:"绿色",
//            style:UIAlertActionStyle.Default,
//            handler:{
//                (action:UIAlertAction) -> Void in
//                self.view.backgroundColor = UIColor.greenColor()
//        }))
//        alert.addAction(UIAlertAction(title:"蓝色",
//            style:UIAlertActionStyle.Default,
//            handler:{
//                (action:UIAlertAction) -> Void in
//                self.view.backgroundColor = UIColor.blueColor()
//        }))
//        alert.addAction(UIAlertAction(title:"黄色",
//            style:UIAlertActionStyle.Default,
//            handler: {
//                (action:UIAlertAction) -> Void in
//                self.view.backgroundColor = UIColor.yellowColor()
//        }))
//        alert.addAction(UIAlertAction(title:"取消",
//            style:UIAlertActionStyle.Cancel,
//            handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

