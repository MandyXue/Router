//
//  DispatchController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud


class DispatchController: NSObject {
    class func dispatchToMain()-> UIViewController {
        if AVUser.currentUser() != nil {
            customerUser()
            return RootTabBarController.loadFromStoryboard()
        }
        else
        {
            return WelcomeViewController.loadFromStoryboard()
        }
    }
    
    class func customerUser() {
        AVUser.currentUser().setObject("lll" as String , forKey: "CarNumber")
        AVUser.currentUser().setObject("https://s3.amazonaws.com/f.cl.ly/items/3O1w3a3U1M0C2N3I3G02/Image%202016-04-28%20at%208.35.35%20AM.png" as String, forKey: "Avatar")
        AVUser.currentUser().saveInBackground()
    }
}
