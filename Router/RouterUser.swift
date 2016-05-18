//
//  File.swift
//  Router
//
//  Created by  Harold LIU on 5/18/16.
//  Copyright © 2016 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

class RouterUser: AVUser {
    // ============================================================
    // Constructors
    // ===========================================================
    
    //必须要有这个Method，无论什么Class
    override class func parseClassName() -> String? {
        return "_User"
    }
    
    //这个必须有，private or not无所谓
    override init() {
        super.init();
    }
    
    override init!(className newClassName: String!) {
        super.init(className: newClassName)
    }
    
    // ============================================================
    // Instance Property
    // ============================================================
    
    //例如，Student这个子类里有一个Property，“name“
    //在OC里的@Dynamic，Swift里应该用@NSManaged
    //请确保 Key Name 和 @NSManaged var 一致，并且不要漏掉 @NSManaged
    @NSManaged var CarNumber : String
    @NSManaged var CarType:String
    @NSManaged var Gender :String
    @NSManaged var Distict:String
    @NSManaged var avatar:AVFile
    
}