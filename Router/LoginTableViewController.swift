//
//  LoginTableViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController {
    
    //MARK:- Outlet
    
    @IBOutlet weak var CloseButton: UIButton!
    @IBOutlet weak var UsernameView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var LoginButton: UIButton!
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        return UIStoryboard.router_loginStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    @IBAction func SignUp() {
    }

    @IBAction func ForgotPassword() {
    }

}
