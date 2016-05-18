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

class AAMessageViewController: JSQMessagesViewController {
    
    var delegateModel: JSQDemoViewControllerDelegate?
    var displayName: String!
    var displaySenderId: String!
    
    // MARK: - BaseViewController
    
    static func loadFromStoryboard() -> UIViewController {
        let controller = UIStoryboard.router_messageStoryboard().instantiateViewControllerWithIdentifier(self.router_className()) as! AAMessageViewController
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: controller)
        return navigationController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        displaySenderId = "Test"
        self.senderId = displaySenderId
        displayName = "Fowafolo"
        self.senderDisplayName = displayName
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

////MARK: - JSQMessagesCollectionViewDataSource
//extension AAMessageViewController: JSQMessagesCollectionViewDataSource {
//    
//}
//
////MARK: - JSQMessagesCollectionViewDelegateFlowLayout
//extension AAMessageViewController: JSQMessagesCollectionViewDelegateFlowLayout {
//    
//}