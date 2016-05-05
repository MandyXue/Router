//
//  SignupTableViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud
import MBProgressHUD

class SignupTableViewController: UITableViewController {
    
    @IBOutlet weak var MailView: UIView!
    @IBOutlet weak var UsernameView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var ConfirmView: UIView!
    @IBOutlet weak var SignUpButton: UIButton!
    
    
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        return UIStoryboard.router_signupStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
    }
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configureUI()
    }
//MARK:- Action
    @IBAction func Close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SignUp() {
        let Username = username.text
        let Password = password.text
        let Email = mailText.text
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Indeterminate
        hud.labelText = "正在注册"

        guard Username != nil && Username?.characters.count != 0 && Password != nil && Password?.characters.count != 0 && Email != nil && Email?.characters.count != 0  else
        {
            hud.mode = .CustomView
            let imageView = UIImage(named: "error")?.imageWithRenderingMode(.AlwaysTemplate)
            hud.customView = UIImageView(image:imageView)
            hud.square = true
            hud.labelText = "用户名或密码不能为空"
            hud.hide(true, afterDelay: 1)
            return
        }
        
        guard Password == confirmPassword.text else
        {
            hud.mode = .CustomView
            let imageView = UIImage(named: "error")?.imageWithRenderingMode(.AlwaysOriginal)
            hud.customView = UIImageView(image:imageView)
            hud.square = true
            hud.labelText = "两次输入密码要一致"
            hud.hide(true, afterDelay: 1)
            return
        }
        
        let user = AVUser()
        user.username = username.text
        user.password = password.text
        user.email = mailText.text
        
        user.signUpInBackgroundWithBlock { (succeed, error) in
            if succeed
            {
                hud.mode = .CustomView
                let imageView = UIImage(named: "Checkmark")?.imageWithRenderingMode(.AlwaysTemplate)
                hud.customView = UIImageView(image:imageView)
                hud.square = true
                hud.labelText = "注册成功"
                hud.hide(true, afterDelay: 1)
                self.delay(2, closure: {
                    UIApplication.sharedApplication().keyWindow?.rootViewController = DispatchController.dispatchToMain()
                })
            }
            else
            {
                hud.mode = .CustomView
                let imageView = UIImage(named: "error")?.imageWithRenderingMode(.AlwaysTemplate)
                hud.customView = UIImageView(image:imageView)
                hud.square = true
                hud.labelText = "用户名已经存在"
                hud.hide(true, afterDelay: 1)
                self.delay(2, closure: {
                    return
                })
            }
         }
    }
    
    func configureUI() {
        tableView.backgroundView = UIImageView(image:UIImage(named: "background"))
        MailView.layer.cornerRadius = MailView.bounds.height/2
        UsernameView.layer.cornerRadius = UsernameView.bounds.height/2
        PasswordView.layer.cornerRadius = PasswordView.bounds.height/2
        ConfirmView.layer.cornerRadius = ConfirmView.bounds.height/2
        UIButton.defaultStyle(SignUpButton)
        
    }
}
