//
//  EditInfoViewController.swift
//  Router
//
//  Created by  Harold LIU on 5/18/16.
//  Copyright © 2016 MandyXue. All rights reserved.
//

import UIKit

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
        } else {
            RouterUser.currentUser().district = editInfo.text!
        }
        
    }
    
    
    
    
}
