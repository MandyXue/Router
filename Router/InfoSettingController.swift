//
//  InfoSettingController.swift
//  Router
//
//  Created by  Harold LIU on 5/18/16.
//  Copyright © 2016 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud
import SDWebImage

class InfoSettingController: UITableViewController {
    
    //MARK:- Params
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var carNumber: UILabel!
    @IBOutlet weak var carType: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var distict: UILabel!
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
    }
    
    func setInfo() {
        usernameLabel.text = AVUser.currentUser().username
        let url = NSURL(string: (AVUser.currentUser().valueForKey("Avatar") as? String)! )
        avatar.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar"))
        carNumber.text = AVUser.currentUser().valueForKey("CarNumber") as? String
        carType.text = AVUser.currentUser().valueForKey("CarType") as? String
        email.text = AVUser.currentUser().email
        phone.text = AVUser.currentUser().mobilePhoneNumber
        gender.text = AVUser.currentUser().valueForKey("Gender") as? String
        distict.text = AVUser.currentUser().valueForKey("Distict") as? String
    }
    
    //MARK:- Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                print("Avatar")
                break
            case 1:
                print("name")
                break
            case 2:
                print("CarNumber")
                break
            case 3:
                print("CarType")
                break
            default:break
            }
        }
        else {
            switch indexPath.row {
            case 0:
                print("email")
                break
            case 1:
                print("phone")
                break
            case 2:
                print("gender")
                break
            case 3:
                print("distict")
                break
            default:break
            }
        }
    }
    
}
