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
//        setInfo()
    }
    
    func setInfo() {
        usernameLabel.text = RouterUser.currentUser().username
        let url = NSURL(string: (RouterUser.currentUser().valueForKey("Avatar") as? String)! )
        avatar.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar"))
        carNumber.text = RouterUser.currentUser().valueForKey("CarNumber") as? String
        carType.text = RouterUser.currentUser().valueForKey("CarType") as? String
        email.text = RouterUser.currentUser().email
        phone.text = RouterUser.currentUser().mobilePhoneNumber
        gender.text = RouterUser.currentUser().valueForKey("Gender") as? String
        distict.text = RouterUser.currentUser().valueForKey("Distict") as? String
    }
    
    //MARK:- Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("editInfo") as! EditInfoViewController
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                print("Avatar")
                break
            case 1:
                vc.title = "修改用户名"
                vc.info = usernameLabel.text
                navigationController?.pushViewController(vc, animated: true)
                break
            default:break
            }
        }
        else {
            switch indexPath.row {
            case 0:
                vc.title = "修改邮箱"
                vc.info = email.text
                navigationController?.pushViewController(vc, animated: true)
                break
            case 1:
                vc.title = "修改手机号"
                vc.info = phone.text
                navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                vc.title = "修改性别"
                vc.info = gender.text
                navigationController?.pushViewController(vc, animated: true)
                break
            case 3:
                vc.title = "修改地区"
                vc.info = distict.text
                navigationController?.pushViewController(vc, animated: true)
                break
            default:break
            }
        }
    }
    
}
