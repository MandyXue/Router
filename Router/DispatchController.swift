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
//            addImages()
            return RootTabBarController.loadFromStoryboard()
        }
        else
        {
            return WelcomeViewController.loadFromStoryboard()
        }
    }
    
    class func addImages() {
        
        let urls = ["http://tupian.enterdesk.com/2013/mxy/12/10/15/3.jpg", "http://img5.imgtn.bdimg.com/it/u=3603943369,1952417318&fm=21&gp=0.jpg", "http://img.taopic.com/uploads/allimg/140326/235113-1403260I33562.jpg", "http://img.taopic.com/uploads/allimg/140720/240467-140H00K62786.jpg", "http://image.tianjimedia.com/uploadImages/2012/011/R5J8A0HYL5YV.jpg"]
        
        for url in urls {
            let user = RouterUser.currentUser()
            let sharing = SharingModel.init()
            sharing.content = "beautiful scene"
            sharing.user = user
            sharing.image = AVFile(URL: url)
            sharing.saveInBackgroundWithBlock { (succeed, error) in
                if succeed {
                    print("succeed")
                } else {
                    print(error)
                }
            }
        }
    }
}
