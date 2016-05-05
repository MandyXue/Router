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
        print("test if have user liu ")
        if AVUser.currentUser() != nil {
            return RootTabBarController.loadFromStoryboard()
        }
        else
        {
            return WelcomeViewController.loadFromStoryboard()
        }
    }
}
