//
//  FriendsViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate {
    
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
            cell.nameLabel.text = allFriends[indexPath.row-2]["name"] as? String
            cell.distanceLabel.text = allFriends[indexPath.row-2]["distance"] as? String
            
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
        cell.nameLabel.text = recommendFriends[indexPath.row]["name"] as? String
        cell.stateLabel.text = recommendFriends[indexPath.row]["state"] as? String
        cell.distanceLabel.text = recommendFriends[indexPath.row]["distance"] as? String
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendFriends.count
    }
    
    // MARK: - Helper
    
    func prepareData() {
        // test data
        for i in 1...10 {
            recommendFriends.append(["name":"推荐\(i)", "distance":"<\(i)km", "state":"离线"])
        }
        for i in 1...20 {
            allFriends.append(["name":"所有\(i)", "distance":"<\(i)km"])
        }
    }
}
