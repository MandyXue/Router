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
        if RouterUser.currentUser() != nil {
            return RootTabBarController.loadFromStoryboard()
        }
        else
        {
            return WelcomeViewController.loadFromStoryboard()
        }
    }
    
    class func customerUser() {
        
        let user = RouterUser.currentUser()
        user.carNumber = "ddf"
        user.carType = "兰博基尼"
        user.saveInBackgroundWithBlock { (result, error) in
            if result {
                print("Save Succeed")
            }
            else {
                print(error)
            }
        }
        
    }
}
