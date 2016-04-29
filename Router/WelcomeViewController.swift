//
//  WelcomeViewController.swift
//  Router
//
//  Created by MandyXue on 16/4/30.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        return UIStoryboard.router_welcomeStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.sharedApplication().windows[0].rootViewController = DispatchController.dispatchToMain()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
