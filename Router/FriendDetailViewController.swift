//
//  FriendDetailViewController.swift
//  Router
//
//  Created by MandyXue on 16/5/18.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

class FriendDetailViewController: UIViewController {
    
    var user = RouterUser()
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
