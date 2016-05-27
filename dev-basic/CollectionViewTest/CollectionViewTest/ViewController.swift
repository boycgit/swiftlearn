//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by JSCON on 16/5/26.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var statesOfMatter:Array<String> = ["Solid","Liquid","Gas"]
    var solids:Array<String> = ["Li","Al","Si"]
    var liquids:Array<String> = ["Hg"]
    var gasses:Array<String> = ["N","O","F"]
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return statesOfMatter.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return solids.count
        } else if section == 1{
            return liquids.count
        } else if section == 2{
            return gasses.count
        }
        
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell:ElementCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ElementCellIdentifier", forIndexPath: indexPath) as! ElementCollectionViewCell
        var elementName:String = "";
        if section == 0{
            elementName = solids[row]
        }else if section == 1{
            elementName = liquids[row]
        } else if section == 2{
            elementName = gasses[row]
        }
        cell.imageView.image = UIImage(named: elementName)
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

