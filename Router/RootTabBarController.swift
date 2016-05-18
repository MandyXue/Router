//
//  RootTabBarController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        return UIStoryboard.router_rootStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let configs : [NSDictionary] = [
            ["Title": "首页",
                "ImageName": "home",
                "SelectedImageName": "home-selected",
                "ViewController": HomeViewController.loadFromStoryboard()],
            ["Title": "聊天",
                "ImageName": "chat",
                "SelectedImageName": "chat-selected",
                "ViewController": AAFriendListTableViewController.loadFromStoryboard()],
            ["Title": "好友",
                "ImageName": "friend",
                "SelectedImageName": "friend-selected",
                "ViewController": FriendsViewController.loadFromStoryboard()],
            ["Title": "发现",
                "ImageName": "find",
                "SelectedImageName": "find-selected",
                "ViewController": DiscoverTableViewController.loadFromStoryboard()],
            ["Title": "设置",
                "ImageName": "setting",
                "SelectedImageName": "setting-selected",
                "ViewController": SettingTableViewController.loadFromStoryboard()]
        ]
        
        var controllers = [UIViewController]()
        
        for config in configs {
            let viewController = config["ViewController"] as! UIViewController
            viewController.tabBarItem = UITabBarItem.init(title: config["Title"] as? String, image: UIImage(named: config["ImageName"] as! String)!.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: config["SelectedImageName"] as! String))
            controllers.append(viewController)
        }
        
        self.setViewControllers(controllers, animated: false)
        
        // tabbar style
        self.tabBar.backgroundImage = UIImage.getImageWithColor(UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1), size: CGSize(width: 320, height: 49))
        let selectedColor = UIColor(red: 255/255, green: 211/255, blue: 0/255, alpha: 1)
        UITabBar.appearance().tintColor = selectedColor
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedColor], forState:.Selected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
