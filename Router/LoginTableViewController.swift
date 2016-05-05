//
//  LoginTableViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud
import MBProgressHUD

class LoginTableViewController: UITableViewController,UITextFieldDelegate{
    
    //MARK:- Outlet
    
    @IBOutlet weak var CloseButton: UIButton!
    @IBOutlet weak var UsernameView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        return UIStoryboard.router_loginStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Username.delegate = self
        Password.delegate = self
        hideKeyboardWhenTappedAround()
        UIConfigure()
    }
    
 //MARK:- Configure UI
    func UIConfigure(){
      tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
      UIButton.defaultStyle(LoginButton)
      UsernameView.layer.cornerRadius = UsernameView.bounds.height/2
      PasswordView.layer.cornerRadius = PasswordView.bounds.height/2
    }
    
    
//MARK:- Action
    @IBAction func Login() {
        let username = Username.text
        let password = Password.text
        let hud =  MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Indeterminate
        hud.labelText = "正在登录"
    
        guard username != nil && username?.characters.count != 0 && password != nil && password?.characters.count != 0 else
        {
            hud.mode = .CustomView
            let imageView = UIImage(named: "error")?.imageWithRenderingMode(.AlwaysTemplate)
            hud.customView = UIImageView(image:imageView)
            hud.square = true
            hud.labelText = "用户名或密码不能为空"
            hud.hide(true, afterDelay: 2)
            return
        }
        
        AVUser.logInWithUsernameInBackground(Username.text, password: Password.text) { (user, error) in
            if (user != nil)
            {
                hud.mode = .CustomView
                let imageView = UIImage(named: "Checkmark")?.imageWithRenderingMode(.AlwaysTemplate)
                hud.customView = UIImageView(image:imageView)
                hud.square = true
                hud.labelText = "登录成功"
                hud.hide(true, afterDelay: 2)
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
                hud.labelText = "用户名或密码错误"
                hud.hide(true, afterDelay: 2)
                self.delay(1, closure: {
                    return
                })
            }
        }
        
    }

    @IBAction func ForgotPassword() {
        
    }

    @IBAction func Close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
