//
//  ViewController.swift
//  SettingsTest
//
//  Created by JSCON on 16/7/13.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let userDefaults = NSUserDefaults()
        let registrationDictionary:[String:String] = ["user_name":"JSCON","user_age":"26"]
        userDefaults.registerDefaults(registrationDictionary)
        userDefaults.synchronize()
        
        nameLabel.text = userDefaults.valueForKey("user_name") as? String
        ageLabel.text = userDefaults.valueForKey("user_age") as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

