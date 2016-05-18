//
//  RecommendCollectionViewCell.swift
//  Router
//
//  Created by MandyXue on 16/5/16.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

class RecommendCollectionViewCell: UICollectionViewCell {
    
    var friend = AVUser() {
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBAction func addFriend(sender: AnyObject) {
        var firstFinished = false
        var secondFinished = false
        func success(){
            if firstFinished && secondFinished {
                let alert = UIAlertView(title: "添加好友成功",
                                        message: "您已添加好友：\(friend.username)",
                                        delegate: nil,
                                        cancelButtonTitle: "Ok")
                alert.show()
            }
        }
        let friendId = friend.objectId
        let userId = AVUser.currentUser().objectId
        let follow = AVObject(className: "Friends")
        follow.setObject(AVObject(className: "_User", objectId: friendId), forKey: "friend")
        follow.setObject(AVObject(className: "_User", objectId: userId), forKey: "user")
        follow.saveInBackgroundWithBlock({(succeed: Bool, error: NSError!) -> Void in
            if succeed {
                firstFinished = true
                success()
            } else {
                print(error)
            }
        })
        let follower = AVObject(className: "Friends")
        follower.setObject(AVObject(className: "_User", objectId: friendId), forKey: "user")
        follower.setObject(AVObject(className: "_User", objectId: userId), forKey: "friend")
        follower.saveInBackgroundWithBlock({(succeed: Bool, error: NSError!) -> Void in
            if succeed {
                secondFinished = true
                success()
            } else {
                print(error)
            }
        })
    }
    
    func updateUI() {
        avatarImageView.image = UIImage(named: "avatar")
        nameLabel.text = friend.username
        distanceLabel.text = "<1km"
    }
    
}
