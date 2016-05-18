//
//  FriendModel.swift
//  Router
//
//  Created by MandyXue on 16/5/17.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

class FriendModel: AVObject, AVSubclassing {
    // ============================================================
    // Constructors
    // ===========================================================
    
    //必须要有这个Method，无论什么Class
    class func parseClassName() -> String? {
        return "Friends"
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
    @NSManaged var friend: RouterUser?
    @NSManaged var user: RouterUser?
    
}