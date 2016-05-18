//
//  AboutUsTableViewController.swift
//  L-FMS
//
//  Created by MandyXue on 16/5/18.
//  Copyright © 2016年 L&FMS. All rights reserved.
//

import UIKit

class AboutUsTableViewController: UITableViewController {
    
    var dataSource = [[String: String]]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = [
            ["username":"同济大学苹果俱乐部", "avatar":"tac", "description":"本组成员属于苹果俱乐部核心成员，拥有丰富的iOS开发经验"],
            ["username":"薛梦迪", "avatar":"xmd", "description":"对iOS设计有浓厚的兴趣，在iOS开发方面也有一定的基础"],
            ["username":"安哲宏", "avatar":"azh", "description":"熟悉iOS开发，编程能力、算法能力强，编程经验丰富"],
            ["username":"刘旭东", "avatar":"lxd", "description":"熟悉iOS开发，学习能力强，在算法、数据挖掘等内容上有所研究"]
        ]
    }
    
    override func viewWillAppear(animated: Bool) {
        if (self.navigationController != nil){
            self.title = "关于我们"
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AboutUsTableViewCellIdentifier", forIndexPath: indexPath) as! AboutUsTableViewCell
        
        cell.avatar?.image = UIImage(named: (dataSource[indexPath.row])["avatar"]!)
        cell.name.text = (dataSource[indexPath.row])["username"]
        cell.introduction.text = (dataSource[indexPath.row])["description"]

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }

}
