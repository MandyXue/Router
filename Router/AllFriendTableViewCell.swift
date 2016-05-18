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
    
    var friend = AVUser() {
        didSet{
            let query = AVQuery(className: "_User")
            query.getObjectInBackgroundWithId(friend.objectId, block: {(object: AnyObject!, error: NSError!) -> Void in
                if let user = object as? AVUser {
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
        avatarImageView.image = UIImage(named: "avatar")
        nameLabel.text = friend.username
        distanceLabel.text = "<1km"
    }

}
