//
//  DispatchController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

class DispatchController: NSObject {
    class func dispatchToMain()-> UIViewController {
//        if LFUser.currentUser() == nil {
//            return WelcomeViewController.loadFromStoryboard()
//        } else {
//            return RootTabBarController.loadFromStoryboard()
//        }
        return WelcomeViewController.loadFromStoryboard()

    }
}
