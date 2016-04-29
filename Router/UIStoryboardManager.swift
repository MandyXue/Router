//
//  UIStoryboardManager.swift
//  Router
//
//  Created by MandyXue on 16/4/29.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    class func router_mainStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
    
    class func router_homeStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Home", bundle: nil)
    }
    
    class func router_welcomeStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Welcome", bundle: nil)
    }
    
    class func router_signupStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Signup", bundle: nil)
    }
    
    class func router_loginStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Login", bundle: nil)
    }
    
    class func router_messageStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Message", bundle: nil)
    }
    
    class func router_friendsStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Friends", bundle: nil)
    }
    
    class func router_discoverStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Discover", bundle: nil)
    }
    
    class func router_settingStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Setting", bundle: nil)
    }
    
    class func router_rootStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: "Root", bundle: nil)
    }
}
