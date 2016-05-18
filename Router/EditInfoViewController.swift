//
//  EditInfoViewController.swift
//  Router
//
//  Created by  Harold LIU on 5/18/16.
//  Copyright © 2016 MandyXue. All rights reserved.
//

import UIKit
import MBProgressHUD

class EditInfoViewController: UITableViewController,UITextFieldDelegate {

    @IBOutlet weak var editInfo: UITextField!
    
    var info :String? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editInfo.delegate = self
        hideKeyboardWhenTappedAround()
        editInfo.text = info
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if title == "修改用户名" {
            RouterUser.currentUser().username = editInfo.text
        } else if title == "修改邮箱" {
            RouterUser.currentUser().email = editInfo.text
        } else if title == "修改手机号" {
            RouterUser.currentUser().mobilePhoneNumber = editInfo.text
        } else if title == "修改性别" {
            RouterUser.currentUser().gender = editInfo.text!
        } else if title == "修改地区" {
            RouterUser.currentUser().district = editInfo.text!
        } else if title == "修改车牌号" {
            RouterUser.currentUser().carNumber = editInfo.text!
        } else {
            RouterUser.currentUser().carType = editInfo.text!
        }
        
        let hud =  MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Indeterminate
        hud.labelText = "正在保存..."
        
        RouterUser.currentUser().saveInBackgroundWithBlock { (result, error) in
            if result {
                hud.mode = .CustomView
                let imageView = UIImage(named: "Checkmark")?.imageWithRenderingMode(.AlwaysTemplate)
                hud.customView = UIImageView(image:imageView)
                hud.square = true
                hud.labelText = "保存成功"
                hud.hide(true, afterDelay: 1)
                self.delay(2, closure: {
                    self.navigationController?.popViewControllerAnimated(true)
                })
            }
            else {
                print(error)
                hud.mode = .Text
                hud.labelText = "手机号码无效"
                hud.hide(true, afterDelay: 1)
            }
        }
    }
}
