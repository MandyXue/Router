//
//  AllFriendTableViewCell.swift
//  Router
//
//  Created by MandyXue on 16/5/16.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

class AllFriendTableViewCell: UITableViewCell {
    
    var friend = RouterUser() {
        didSet{
            let query = AVQuery(className: "_User")
            query.getObjectInBackgroundWithId(friend.objectId, block: {(object: AnyObject!, error: NSError!) -> Void in
                if let user = object as? RouterUser {
                    self.friend = user
                    self.updateUI()
                } else {
                    print(error)
                }
            })
        }
    }

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        AVFile.getFileWithObjectId(friend.avatar?.objectId) { (file: AVFile!, error: NSError!) in
            if (error == nil) {
                let data = file.getData()
                let image = UIImage(data: data)
                self.avatarImageView.image = image
            } else {
                print(error)
            }
        }
        nameLabel.text = friend.username
        distanceLabel.text = "<1km"
    }

}
