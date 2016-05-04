//
//  SignupTableViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

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
        configureUI()
    }
//MARK:- Action
    @IBAction func Close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SignUp() {
        
       if checkInput(username.text) && checkInput(password.text) && checkInput(mailText.text)
       {
        
        let user = AVUser()
        user.username = username.text
        user.password = password.text
        user.email = mailText.text
        
        user.signUpInBackgroundWithBlock { (succeed, error) in
            if succeed
            {
                print("Sign Up Succeed")
                
            }
            else
            {
                print("Sign Up Fail, User name alreay haved")
            }
         }
        }
        else
       {
        print("Invalid Input")
       }
    }
    
    
    func checkInput(input:String?) -> Bool {
        return true
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
