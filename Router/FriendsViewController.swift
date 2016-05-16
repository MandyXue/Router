//
//  FriendsViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Data Source
    
    var recommendFriends: [NSDictionary] = []
    var allFriends: [NSDictionary] = []
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var addFriendView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        let controller = UIStoryboard.router_friendsStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
        if controller.navigationController != nil {
            return controller.navigationController!
        }
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: controller)
        return navigationController
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "好友"
        
        // set tableview
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View Data Source
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("RecommendCell") as! RecommendTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("AllFriendLabelCell")
            return cell!
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("AllFriendCell")
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 160.0
        case 1:
            return 60.0
        default:
            return 62.0
        }
    }
    
    // MARK: - Helper
    
    func prepareData() {
        
    }
}
