//
//  WelcomeViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/30.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

//MARK:- Outlet
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
// MARK: - BaseViewController

    static func loadFromStoryboard() -> UIViewController {
        return UIStoryboard.router_welcomeStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
    }
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        UIButton.defaultStyle(RegisterButton)
        UIButton.defaultStyle(LoginButton)
    }

}
