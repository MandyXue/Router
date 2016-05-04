//
//  SignupTableViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

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

    func configureUI() {
        tableView.backgroundView = UIImageView(image:UIImage(named: "background"))
        MailView.layer.cornerRadius = MailView.bounds.height/2
        UsernameView.layer.cornerRadius = UsernameView.bounds.height/2
        PasswordView.layer.cornerRadius = PasswordView.bounds.height/2
        ConfirmView.layer.cornerRadius = ConfirmView.bounds.height/2
        UIButton.defaultStyle(SignUpButton)
        
    }
    
    @IBAction func Close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func SignUp() {
    }
    
    @IBAction func toLogin() {
    }
    
}
