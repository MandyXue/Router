//
//  FriendsViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud
import MBProgressHUD

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Data Source
    
    var recommendFriends: [AVUser] = []
    var allFriends: [AVUser] = []
    
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
        prepareData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View Data Source
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("RecommendCell") as! RecommendTableViewCell
            cell.setCollectionViewDataSourceAndDelegate(dataSourceAndDelegate: self)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("AllFriendLabelCell")
            return cell!
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("AllFriendCell") as! AllFriendTableViewCell
            cell.friend = allFriends[indexPath.row-2]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFriends.count+2
    }
    
    // MARK: - Table View Delegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200.0
        case 1:
            return 60.0
        default:
            return 62.0
        }
    }
    
    // MARK: - Collection View Data Source
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecommendCollection", forIndexPath: indexPath) as! RecommendCollectionViewCell
        cell.friend = recommendFriends[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendFriends.count
    }
    
    // MARK: - Helper
    
    func selectRecommends() {
        for friend in allFriends {
            var i = 0
            for recommendFriend in recommendFriends {
                if recommendFriend.objectId == friend.objectId {
                    self.recommendFriends.removeAtIndex(i)
                }
                i = i + 1
            }
        }
        tableView.reloadData()
    }
    
    func prepareData() {
        // lean cloud
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .AnnularDeterminate
        hud.labelText = "loading"
        var userFinished = false
        var friendFinished = true
        func finish() {
            if userFinished && friendFinished {
                hud.hide(true)
                selectRecommends()
            }
        }
        // recommend
        let userQuery = AVQuery(className: "_User")
        userQuery.findObjectsInBackgroundWithBlock({(objects:[AnyObject]!, error:NSError!) -> Void in
            if (error == nil) {
                for object in objects {
                    if let user = object as? AVUser {
                        if user.username != AVUser.currentUser().username {
                            self.recommendFriends.append(user)
                        }
                    }
                }
                userFinished = true
                finish()
            } else {
                print(error)
            }
        })
        // friends
        let friendQuery = FriendModel.query()
        friendQuery.findObjectsInBackgroundWithBlock({(objects:[AnyObject]!, error:NSError!) -> Void in
            if (error == nil) {
                for object in objects {
                    if let user = object as? FriendModel {
                        if (user.user?.objectId == AVUser.currentUser().objectId && user.friend != nil) {
                            self.allFriends.append(user.friend!)
                        }
                    }
                }
                friendFinished = true
                finish()
            } else {
                print(error)
            }
        })
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FriendDetailSegue" {
            if let detailViewController = segue.destinationViewController as? FriendDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    if let friendCell = tableView.cellForRowAtIndexPath(indexPath) as? AllFriendTableViewCell {
                        detailViewController.user = friendCell.friend
                        friendCell.setSelected(false, animated: false)
                    }
                }
            }
        }
    }
    
}
