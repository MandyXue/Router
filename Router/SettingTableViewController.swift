//
//  SettingTableViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud
import SDWebImage

class SettingTableViewController: UITableViewController {
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        let controller = UIStoryboard.router_settingStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: controller)
        return navigationController
    }
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var carNumber: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        avatar.layer.cornerRadius = 10
       
        
        print("==============================")
        let user = RouterUser.currentUser()
        user.carNumber = "ddf"
        user.carType = "兰博基尼"
        user.saveInBackgroundWithBlock { (result, error) in
            if result {
                print("Save Succeed")
            }
            else {
                print(error)
            }
        }
        print(RouterUser.currentUser().carType)
        //setUerInfo()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    }
    
    func setUerInfo()  {
        username.text = RouterUser.currentUser().username
        print(RouterUser.currentUser().carNumber)
       // carNumber.text = "车牌号：\(RouterUser.currentUser().carNumber))"
        let url = NSURL(string: RouterUser.currentUser().valueForKey("Avatar") as! String )
        avatar.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar"))
    }
    
    //MARK:- Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            let vc = storyboard?.instantiateViewControllerWithIdentifier("InfoSetting")
            vc?.title = "修改信息"
            navigationController?.pushViewController(vc!, animated: true)
            break
        case 1:
            switch indexPath.row {
            case 0:
                let vc = storyboard?.instantiateViewControllerWithIdentifier("privacy")
                vc?.title = "隐私设置"
                navigationController?.pushViewController(vc!, animated: true)
                break
            case 1:
                print("version")
                break
            case 2:
                print("comment")
                break
            case 3:
                print("about us")
                break
            default:break
            }
            break
        case 2:
            RouterUser.logOut()
            let sb = UIStoryboard(name: "Welcome", bundle: nil)
            presentViewController(sb.instantiateViewControllerWithIdentifier("WelcomeViewController"), animated: true, completion: nil)
            break
        default:break
        }
        
    }
}
