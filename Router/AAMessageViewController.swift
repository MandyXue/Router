//
//  AAMessageViewController.swift
//  Router
//
//  Created by FOWAFOLO on 16/5/17.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import JSQMessagesViewController

protocol JSQDemoViewControllerDelegate {
    func didDismissJSQDemoViewController(vc: AAMessageViewController)
}

class AAMessageViewController: UIViewController {
    
    var delegateModel: JSQDemoViewControllerDelegate?
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        let controller = UIStoryboard.router_messageStoryboard().instantiateViewControllerWithIdentifier(self.router_className())
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: controller)
        return navigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "聊天"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.delegateModel != nil {
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        self.collectionView.collectionViewLayout.springinessEnabled = true
    }
}
