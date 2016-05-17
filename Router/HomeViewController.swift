//
//  HomeViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import PageMenu

class HomeViewController: UIViewController {
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        let controller = UIStoryboard.router_homeStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: controller)
        return navigationController
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = UIColor(patternImage: UIImage(named: "home_background")!)
        configurePageMenu()
    }
    //MARK:- Configure Page Menu
    func configurePageMenu()  {
        var pageMenu : CAPSPageMenu?
        var controllerArray : [UIViewController] = []
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 78/255, green: 146/255, blue: 223/255, alpha: 1)),
            .SelectionIndicatorColor(UIColor.whiteColor()),
            .UnselectedMenuItemLabelColor (UIColor.whiteColor()),
            .MenuItemWidth(UIScreen.mainScreen().bounds.width/2 - 20),
            .MenuItemSeparatorColor (UIColor.whiteColor()),
            .CenterMenuItems(true)
        ]
        let firstController = storyboard?.instantiateViewControllerWithIdentifier("firstController")
        let secondController = storyboard?.instantiateViewControllerWithIdentifier("secondController")
        firstController!.title = "我的摄像头"
        secondController?.title = "附近商家"
        controllerArray.append(firstController!)
        controllerArray.append(secondController!)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, (self.navigationController?.navigationBar.bounds.height)!+statusBarHeight(), self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        self.view.addSubview(pageMenu!.view)
        self.addChildViewController(pageMenu!)
    }
    
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.sharedApplication().statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }
}
