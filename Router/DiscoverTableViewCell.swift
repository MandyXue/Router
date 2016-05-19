//
//  DiscoverTableViewCell.swift
//  Router
//
//  Created by MandyXue on 16/5/18.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

class DiscoverTableViewCell: UITableViewCell {
    
    var sharing = SharingModel() {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var discoverImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        username.text = sharing.username
        content.text = sharing.content
        date.text = dateToString(sharing.createdAt)
        AVFile.getFileWithObjectId(sharing.image!.objectId) { (file: AVFile!, error: NSError!) in
            if (error == nil) {
                let data = file.getData()
                if (data != nil) {
                    let image = UIImage(data: data)
                    self.discoverImage.image = image
                }
            } else {
                print(error)
            }
        }
    }
    
    func dateToString(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let string = dateFormatter.stringFromDate(date)
        return string
    }

}
