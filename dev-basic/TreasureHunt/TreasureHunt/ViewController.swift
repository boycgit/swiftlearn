//
//  ViewController.swift
//  TreasureHunt
//
//  Created by JSCON on 16/5/16.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var largeImage: UIImageView!
    @IBOutlet weak var animatedImage: UIImageView!
    
    func handleTap(sender:UITapGestureRecognizer){
        let startLocation:CGPoint = sender.locationInView(self.largeImage)
        let scaleFactor = self.largeImage.frame.size.height / 430.0;
        if((startLocation.y >= 211 * scaleFactor) && (startLocation.y <= (211+104)*scaleFactor)){
            animatedImage.hidden = false
            animatedImage.startAnimating()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 注册单击事件
        let tapRecognizer = UITapGestureRecognizer(target:self,action:Selector("handleTap:"))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        // 设置动画帧
        let frameArray:[UIImage] = [
            UIImage(named:"animframe1")!,
            UIImage(named:"animframe2")!,
            UIImage(named:"animframe3")!,
            UIImage(named:"animframe4")!,
            UIImage(named:"animframe5")!,
            UIImage(named:"animframe6")!
        ]
        animatedImage.animationImages = frameArray
        animatedImage.animationDuration = 0.5
        animatedImage.animationRepeatCount = 1
        animatedImage.userInteractionEnabled = false
        animatedImage.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

