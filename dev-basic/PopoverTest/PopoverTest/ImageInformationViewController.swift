//
//  ImageInformationViewController.swift
//  PopoverTest
//
//  Created by JSCON on 16/6/23.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ImageInformationViewController: UIViewController {

    @IBOutlet weak var imageHeight: UITextField!
    @IBOutlet weak var imageWidth: UITextField!
    @IBOutlet weak var imageColorSpace: UITextField!
    var imageBeingDisplayed:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let imageSize = imageBeingDisplayed.size
        let height = imageSize.height
        let width = imageSize.width
        
        imageHeight.text = "\(height)"
        imageWidth.text = "\(width)"
        imageColorSpace.text = "RGB"
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
