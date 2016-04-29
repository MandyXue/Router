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
                "ViewController": MessageTableViewController.loadFromStoryboard()],
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
            viewController.tabBarItem = UITabBarItem.init(title: config["Title"] as? String, image: UIImage(named: config["ImageName"] as! String), selectedImage: UIImage(named: config["SelectedImageName"] as! String))
            controllers.append(viewController)
        }
        
        self.setViewControllers(controllers, animated: false)
        
        self.tabBar.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
