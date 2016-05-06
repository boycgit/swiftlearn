//
//  ViewController.swift
//  FruitList
//
//  Created by JSCON on 16/4/24.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var arrayOfFruits:[FruitClass] = [FruitClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let apple:FruitClass = FruitClass(fruitName: "Apple", fruitImage: "apple", fruitFamily: "Rosacae", fruitGenus: "Malus")
        
        let banana:FruitClass = FruitClass(fruitName: "Banana", fruitImage: "banana", fruitFamily: "Musacae", fruitGenus: "Musa")
        
        let orange:FruitClass = FruitClass(fruitName: "Orange", fruitImage: "orange", fruitFamily: "Rutacae", fruitGenus: "Citrus")
        
        arrayOfFruits.append(apple);
        arrayOfFruits.append(banana);
        arrayOfFruits.append(orange);
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "appleSegue"){
            let objectData :FruitClass = self.arrayOfFruits[0]
            let destination = segue.destinationViewController as! FruitDetailViewController
            destination.dataObject = objectData
        }else if (segue.identifier == "bananaSegue") {
            let objectData:FruitClass = self.arrayOfFruits[1]
            let destination = segue.destinationViewController as! FruitDetailViewController
            
            destination.dataObject = objectData;
            
        } else if (segue.identifier == "orangeSegue") {
            let objectData:FruitClass = self.arrayOfFruits[2]
            let destination = segue.destinationViewController as! FruitDetailViewController
            
            destination.dataObject = objectData;
            
        }
    }


}

