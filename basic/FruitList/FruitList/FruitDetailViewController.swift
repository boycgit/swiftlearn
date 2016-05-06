//
//  FruitDetailViewController.swift
//  FruitList
//
//  Created by JSCON on 16/4/26.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class FruitDetailViewController: UIViewController {
    
    var dataObject:FruitClass?

    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var fruitNameLabel: UILabel!
    @IBOutlet weak var fruitFamilyLabel: UILabel!
    @IBOutlet weak var fruitGenusLabel: UILabel!
    @IBAction func onBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataObject = dataObject else {
            return
        }

        fruitImage.image = UIImage(named:dataObject.fruitImage)
        fruitNameLabel.text = "水果名称：\(dataObject.fruitName)"
        fruitFamilyLabel.text = "水果家族：\(dataObject.fruitFamily)"
        fruitGenusLabel.text = "水果品种：\(dataObject.fruitGenus)"
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
