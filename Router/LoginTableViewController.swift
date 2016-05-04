//
//  LoginTableViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

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
        dismissKeyboard()
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
        AVUser.logInWithUsernameInBackground(Username.text, password: Password.text) { (user, error) in
            if (user != nil)
            {
            
                
            }
            else
            {
                print(error)
            }
        }
        
    }

    @IBAction func ForgotPassword() {
    }

    @IBAction func Close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
