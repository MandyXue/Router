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
        print("----?")
        if AVUser.currentUser() == nil {
        print("No User")
            return WelcomeViewController.loadFromStoryboard()
        } else {
            
            return RootTabBarController.loadFromStoryboard()
        }
    }
}
