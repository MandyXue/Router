//
//  DiscoverTableViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud
import MBProgressHUD

class DiscoverTableViewController: UITableViewController {
    
    var sharings: [SharingModel] = []
    var usernames: [String] = []
    var images: [UIImage] = []
    
    
    @IBAction func refresh(sender: UIRefreshControl) {
        sharings = []
        usernames = []
        images = []
        let sharingQuery = AVQuery(className: "Sharing")
        sharingQuery.findObjectsInBackgroundWithBlock({(objects:[AnyObject]!, error:NSError!) -> Void in
            if (error == nil) {
                for object in objects {
                    if let sharing = object as? SharingModel {
                        self.sharings.append(sharing)
                        AVFile.getFileWithObjectId(sharing.image?.objectId) { (file: AVFile!, error: NSError!) in
                            if (error == nil) {
                                let data = file.getData()
                                if data != nil {
                                    let image = UIImage(data: data)
                                    self.images.append(image!)
                                }
                            } else {
                                print(error)
                            }
                            self.tableView.reloadData()
                            sender.endRefreshing()
                            let hud =  MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                            hud.mode = .CustomView
                            let imageView = UIImage(named: "Checkmark")?.imageWithRenderingMode(.AlwaysTemplate)
                            hud.customView = UIImageView(image:imageView)
                            hud.square = true
                            hud.labelText = "加载成功"
                            hud.hide(true, afterDelay: 2)
                        }
                    }
                }
            } else {
                sender.endRefreshing()
                let alert = UIAlertView(title: "错误❌",
                    message: "错误信息：\(error.description)",
                    delegate: nil,
                    cancelButtonTitle: "Ok")
                alert.show()
            }
        })
    }
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        let controller = UIStoryboard.router_discoverStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: controller)
        return navigationController
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        tableView.delegate = self
        tableView.dataSource = self
        
        getSharings()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sharings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscoverCell", forIndexPath: indexPath) as! DiscoverTableViewCell
        
        cell.username.text = sharings[indexPath.row].username
        cell.content.text = sharings[indexPath.row].content
        
        if indexPath.row < images.count {
            cell.discoverImage.image = images[indexPath.row]
        }
        
        cell.date.text = dateToString(sharings[indexPath.row].createdAt)

        return cell
    }
    
    // MARK: - Helper
    
    func refresh(){
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl!)
    }
    
    func dateToString(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let string = dateFormatter.stringFromDate(date)
        return string
    }
    
    func getSharings() {
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .AnnularDeterminate
        hud.labelText = "loading"
        // recommend
        let sharingQuery = AVQuery(className: "Sharing")
        sharingQuery.findObjectsInBackgroundWithBlock({(objects:[AnyObject]!, error:NSError!) -> Void in
            if (error == nil) {
                for object in objects {
                    if let sharing = object as? SharingModel {
                        self.sharings.append(sharing)
                        AVFile.getFileWithObjectId(sharing.image?.objectId) { (file: AVFile!, error: NSError!) in
                            if (error == nil) {
                                let data = file.getData()
                                if data != nil {
                                    let image = UIImage(data: data)
                                    self.images.append(image!)
                                }
                            } else {
                                print(error)
                            }
                            hud.hide(true)
                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                print(error)
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
