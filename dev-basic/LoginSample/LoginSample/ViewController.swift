//
//  ViewController.swift
//  LoginSample
//
//  Created by JSCON on 16/5/9.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func onDismissKeyboard(sender: AnyObject) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }

    @IBAction func onLogin(sender: AnyObject) {
                usernameField.resignFirstResponder()
                passwordField.resignFirstResponder()
        
        let userName:String = usernameField.text!
        let length:Int = userName.characters.count
        
        if length == 0 {
            
            return
        }
        
        let alert = UIAlertController(title: "",
                                      message: "登录成功",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "确认",
            style: UIAlertActionStyle.Default,
            handler: nil))
        
        self.presentViewController(alert,
                                   animated: true,
                                   completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapRecognizer = UITapGestureRecognizer(target:self,
                                                   action:#selector(ViewController.handleBackgroundTap(_:)))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleBackgroundTap(sender:UITapGestureRecognizer){
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }

}

