//
//  AAFriendListTableViewController.swift
//  Router
//
//  Created by FOWAFOLO on 16/5/18.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

class AAFriendListTableViewController: UITableViewController {
    
    var allFriends: [RouterUser] = [RouterUser]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getFriends()
        self.title = "聊天"
    }
    
    static func loadFromStoryboard() -> UIViewController {
        let controller = UIStoryboard.router_messageStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: controller)
        return navigationController
    }
    
    func getFriends() {
        // friends
        let friendQuery = FriendModel.query()
        friendQuery.findObjectsInBackgroundWithBlock({(objects:[AnyObject]!, error:NSError!) -> Void in
            if (error == nil) {
                for object in objects {
                    if let user = object as? FriendModel {
                        if (user.user?.objectId == RouterUser.currentUser().objectId && user.friend != nil) {
                            self.allFriends.append(user.friend!)
                        }
                    }
                }
                self.tableView.reloadData()
            } else {
                print(error)
            }
        })
    }
    
}

extension AAFriendListTableViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.allFriends.count > 0 {
            return allFriends.count
        }else {
            return 0
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AAFriendListTableViewCell", forIndexPath: indexPath) as! AAFriendListTableViewCell
        let currentFriend = allFriends[indexPath.row]
        cell.friend = currentFriend
        cell.tag = indexPath.row
        return cell
    }
}

extension AAFriendListTableViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = AAMessageViewController()
        detailController.messageIndex = indexPath.row % 4
        detailController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}