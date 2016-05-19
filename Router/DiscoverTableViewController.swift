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
                        self.tableView.reloadData()
                        sender.endRefreshing()
                        
//                        AVFile.getFileWithObjectId(sharing.image?.objectId) { (file: AVFile!, error: NSError!) in
//                            if (error == nil) {
//                                let data = file.getData()
//                                if data != nil {
//                                    let image = UIImage(data: data)
//                                    self.images.append(image!)
//                                }
//                            } else {
//                                print(error)
//                            }
//                            
//                        }
                    }
                }
                let hud =  MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.mode = .CustomView
                let imageView = UIImage(named: "Checkmark")?.imageWithRenderingMode(.AlwaysTemplate)
                hud.customView = UIImageView(image:imageView)
                hud.square = true
                hud.labelText = "加载成功"
                hud.hide(true, afterDelay: 2)
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
        
//        getSharings()
        
        if self.navigationController != nil {
            let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addTapped))
            self.navigationItem.rightBarButtonItem = add
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        refresh()
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
        if indexPath.row < sharings.count {
            let count = sharings.count - indexPath.row - 1
            cell.sharing = sharings[count]
        }
        
        return cell
    }
    
    // MARK: - Helper
    
    func addTapped() {
        self.navigationController?.pushViewController(NewDiscoverViewController.loadFromStoryboard(), animated: true)
    }
    
    func refresh(){
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl!)
    }
//    
//    func getSharings() {
//        sharings = []
//        usernames = []
//        images = []
//        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        hud.mode = .AnnularDeterminate
//        hud.labelText = "loading"
//        // recommend
//        let sharingQuery = AVQuery(className: "Sharing")
//        sharingQuery.findObjectsInBackgroundWithBlock({(objects:[AnyObject]!, error:NSError!) -> Void in
//            if (error == nil) {
//                for object in objects {
//                    if let sharing = object as? SharingModel {
//                        self.sharings.append(sharing)
//                        AVFile.getFileWithObjectId(sharing.image?.objectId) { (file: AVFile!, error: NSError!) in
//                            if (error == nil) {
//                                let data = file.getData()
//                                if data != nil {
//                                    let image = UIImage(data: data)
//                                    self.images.append(image!)
//                                }
//                            } else {
//                                print(error)
//                            }
//                            hud.hide(true)
//                            self.tableView.reloadData()
//                        }
//                    }
//                }
//            } else {
//                print(error)
//            }
//        })
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
