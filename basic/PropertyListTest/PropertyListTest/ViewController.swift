//
//  ViewController.swift
//  PropertyListTest
//
//  Created by JSCON on 16/7/6.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfContacts:NSArray? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 载入contact.plist文件中的内容
        let documentsDirectory:String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        let plistPath = documentsDirectory + "/contacts.plist"
        
        arrayOfContacts = NSArray(contentsOfFile:plistPath)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfContacts!.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("prototypeCell1",forIndexPath: indexPath) as UITableViewCell
        let contactName:String = arrayOfContacts!.objectAtIndex(indexPath.row) as! String
        
        cell.textLabel?.text = contactName
        
        return cell
    }


}

