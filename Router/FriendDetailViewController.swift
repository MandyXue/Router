//
//  FriendDetailViewController.swift
//  Router
//
//  Created by MandyXue on 16/5/18.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

class FriendDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var user = RouterUser()
    var images: [UIImage] = []
    
    // MARK: - IBActions
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func sendMessage(sender: AnyObject) {
        print("send message")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set datasource and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        // set UI
        self.title = user.username
        nameLabel.text = user.username
        carTypeLabel.text = user.carType
        AVFile.getFileWithObjectId(user.avatar?.objectId) { (file: AVFile!, error: NSError!) in
            if (error == nil) {
                let data = file.getData()
                let image = UIImage(data: data)
                self.avatarImageView.image = image
            } else {
                print(error)
            }
        }
        // get sharing
        getSharings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View Data Source
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DetailCollectionCell", forIndexPath: indexPath) as! DetailCollectionViewCell
        cell.image.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // MARK: - Helper
    
    func getSharings() {
        // recommend
        let sharingQuery = AVQuery(className: "Sharing")
        sharingQuery.findObjectsInBackgroundWithBlock({(objects:[AnyObject]!, error:NSError!) -> Void in
            if (error == nil) {
                for object in objects {
                    if let sharing = object as? SharingModel {
                        if let objectId = sharing.user?.objectId {
                            if objectId == self.user.objectId {
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
                                    self.collectionView.reloadData()
                                }
                            }
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
