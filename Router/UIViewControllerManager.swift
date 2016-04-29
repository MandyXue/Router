//
//  UIViewControllerManager.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol RouterBaseViewController {
    /**
     return the viewController instance loaded from required storyboard.
     - returns:
     */
    optional static func loadFromStoryboard()-> UIViewController
}

extension UIViewController: RouterBaseViewController {
    
    class func router_className()-> String {
        return String(Mirror(reflecting: self).subjectType).componentsSeparatedByString(".").first!
    }
    
    func router_className() -> String {
        return String(Mirror(reflecting: self).subjectType)
    }
    
}