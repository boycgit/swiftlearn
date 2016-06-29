//
//  ViewController.swift
//  PopoverTest
//
//  Created by JSCON on 16/6/23.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        image = UIImage(named:"Sunflower")
        imageView.image = image
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "imageInformationSegue"{
            let viewController:ImageInformationViewController = segue.destinationViewController as! ImageInformationViewController
            viewController.imageBeingDisplayed = self.image
            
        }
    }
    

}

