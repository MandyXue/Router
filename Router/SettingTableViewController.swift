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
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setUerInfo()
    }
    
    func setUerInfo()  {
        username.text = RouterUser.currentUser().username
        if let carNum = RouterUser.currentUser().carNumber {
            carNumber.text = "车牌号：\(carNum)"
        } else {
            carNumber.text = "请输入车牌号"
        }
        AVFile.getFileWithObjectId(RouterUser.currentUser().avatar?.objectId) { (file: AVFile!, error: NSError!) in
            if (error == nil) {
                let data = file.getData()
               self.avatar.image = UIImage(data: data)
            } else {
                print(error)
            }
        }
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
