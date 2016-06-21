//
//  ViewController.swift
//  ScrollingForms
//
//  Created by JSCON on 16/6/8.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit


private extension Selector {
    static let keyboardDidShow = #selector(ViewController.keyboardDidShow(_:))
    static let keyboardDidHide = #selector(ViewController.keyboardDidHide(_:))
}


class ViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var addressField1: UITextField!
    @IBOutlet weak var addressField2: UITextField!
    @IBOutlet weak var postcodeField: UITextField!
    var keyboardHeight:Float = 0.0
    var currentTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        passwordField.delegate = self
        addressField1.delegate = self
        addressField2.delegate = self
        postcodeField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardDidShow, name: UIKeyboardDidShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: .keyboardDidHide, name: UIKeyboardDidHideNotification, object: nil)
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIKeyboardDidShowNotification,object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,name:UIKeyboardDidHideNotification,object: nil)
        
    }
    
    
    func keyboardDidShow(sender: NSNotification){
        
        // 获取键盘高度
        let info:NSDictionary = sender.userInfo!
        let value:NSValue = info.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardFrame:CGRect = value.CGRectValue()
        
        // 将CGFloat转换成Swift中的Float值
        let cgFloatKeyboardHeight:CGFloat = keyboardFrame.size.height
        keyboardHeight =  Float(cgFloatKeyboardHeight)
        
        // 确保当前text是可见的
        // 调整scroll视图中合适的offset距离
        let textFieldTop:Float = Float(currentTextField.frame.origin.y)
        let textFieldBottom:Float = textFieldTop + Float(currentTextField.frame.size.height)
        
        // 如果距离底部比键盘高，说明被键盘遮挡住了
        if(textFieldBottom > keyboardHeight){
            scrollView.setContentOffset(CGPointMake(0,CGFloat(textFieldBottom-keyboardHeight)), animated: true)
        }
        
        
    }
    
    func keyboardDidHide(sender:NSNotification){
        scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        currentTextField = textField
        let textFieldTop:Float = Float(currentTextField.frame.origin.y)
        let textFieldBottom:Float = textFieldTop + Float(currentTextField.frame.size.height)
        if textFieldBottom > keyboardHeight && keyboardHeight != 0.0 { scrollView.setContentOffset(CGPointMake(0, CGFloat(textFieldBottom - keyboardHeight)), animated: true) }
    }


}

