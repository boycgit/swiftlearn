//
//  FruitClass.swift
//  FruitList
//
//  Created by JSCON on 16/4/26.
//  Copyright © 2016年 JSCON. All rights reserved.
//

import UIKit
import Foundation

class FruitClass: NSObject {
    var fruitName:String!
    var fruitImage:String!
    var fruitFamily:String!
    var fruitGenus : String!

    init (fruitName:String, fruitImage:String, fruitFamily:String, fruitGenus:String) {
        self.fruitName = fruitName;
        self.fruitImage = fruitImage;
        self.fruitFamily = fruitFamily;
        self.fruitGenus = fruitGenus;
        
    }
}
