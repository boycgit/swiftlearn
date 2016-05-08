//
//  ViewController.swift
//  GestureTest
//
//  Created by JSCON on 16/5/8.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gestureType: UILabel!
    @IBAction func onTapGestureDetected(sender: AnyObject) {
        gestureType.text = "探测到事件：Tap"
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

