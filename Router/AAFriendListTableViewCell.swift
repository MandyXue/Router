//
//  AAFriendListTableViewCell.swift
//  Router
//
//  Created by FOWAFOLO on 16/5/18.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

class AAFriendListTableViewCell: UITableViewCell {
    
    let fakeMessage = ["学霸今天晚上请吃火锅", "学霸今天晚上请吃冰激凌", "学霸今天晚上请吃披萨", "学霸今天晚上请吃麦当劳",
                       "学霸昨天晚上请吃火锅", "学霸昨天晚上请吃冰激凌", "学霸昨天晚上请吃披萨", "学霸昨天晚上请吃麦当劳",
                       "学霸明天晚上请吃火锅", "学霸明天晚上请吃冰激凌", "学霸明天晚上请吃披萨", "学霸明天晚上请吃麦当劳"]
    
    let fakeTime = ["2016年5月18日 17:05", "2016年5月18日 18:15", "2016年5月18日 20:51", "2016年5月18日 20:55",
                    "2016年5月18日 17:05", "2016年5月18日 17:05", "2016年5月18日 17:05", "2016年5月18日 17:05"]
    
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
    
    func updateUI() {
        AVFile.getFileWithObjectId(friend.avatar?.objectId) { (file: AVFile!, error: NSError!) in
            if (error == nil) {
                let data = file.getData()
                let image = UIImage(data: data)
                self.avator.image = image
            } else {
                print(error)
            }
        }
        nameLabel.text = friend.username
        latestContentLabel.text = fakeMessage[self.tag]
        timeLabel.text = fakeTime[self.tag]
    }

    
    
    @IBOutlet weak var avator: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latestContentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
    }
    
}
