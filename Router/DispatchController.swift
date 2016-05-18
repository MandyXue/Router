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
 //           customerUser()
            return RootTabBarController.loadFromStoryboard()
        }
        else
        {
            return WelcomeViewController.loadFromStoryboard()
        }
    }
    
    class func customerUser() {
        
        RouterUser.currentUser().CarNumber = "ddf"
        RouterUser.currentUser().CarType = "兰博基尼"
        RouterUser.currentUser().Gender = "男"
        RouterUser.currentUser().Distict = "上海市  嘉定区"
        RouterUser.currentUser().saveInBackgroundWithBlock { (result, error) in
            if result {
                print("Save Succeed")
            }
            else {
                print(error)
            }
        }
        
    }
}
