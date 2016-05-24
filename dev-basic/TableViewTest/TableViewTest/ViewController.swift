//
//  ViewController.swift
//  TableViewTest
//
//  Created by JSCON on 16/5/24.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var continents:Array<String> = ["Asia","North America","Europe","Australia"]
    
    var citiesInAsia:Array<String>=["Bangkok","New Delhi","Singapore","Tokyo"]
    var citiesInNorthAmerica:Array<String> = ["San Francisco","Cupertino"]
    var citiesInEurope:Array<String> = ["London", "Paris", "Rome", "Athens"]
    var citiesInAustralia:Array<String> = ["Sydney", "Melbourne", "Cairns"]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return continents.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return citiesInAsia.count
        } else if section == 1{
            return citiesInNorthAmerica.count
        } else if section == 2{
            return citiesInEurope.count
        } else if section == 3{
            return citiesInAustralia.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return continents[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("prototypeCell1",forIndexPath: indexPath)
        if indexPath.section == 0{
            cell.textLabel?.text = citiesInAsia[indexPath.row]
        } else if indexPath.section == 1{
            cell.textLabel?.text = citiesInNorthAmerica[indexPath.row]
        }else if indexPath.section == 2 {
            cell.textLabel?.text = citiesInEurope[indexPath.row]
        } else if indexPath.section == 3 {
            cell.textLabel?.text = citiesInAustralia[indexPath.row]
        }
        
        return cell
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

