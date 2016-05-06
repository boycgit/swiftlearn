//
//  ViewController.swift
//  Adaptive
//
//  Created by JSCON on 16/4/20.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var someButton: UIButton!

    @IBAction func onButtonPressed(sender: AnyObject) {
        textLabel.text = "Hello World"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be Srecreated.
    }
}

