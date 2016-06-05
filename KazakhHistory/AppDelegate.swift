//
//  AppDelegate.swift
//  KazakhHistory
//
//  Created by Zhanserik on 5/15/16.
//  Copyright © 2016 Kenes Inc. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        window?.rootViewController = MenuViewController()
        window?.tintColor = UIColor.whiteColor()
        
        setupBarButtonItemAppearance()
        setupNavigationBarAppearance()
        setupSegmentedControlAppearance()
        return true
    }
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = UIColor.appTintColor()
        appearance.shadowImage = UIImage()
        appearance.titleTextAttributes = [ NSFontAttributeName: UIFont.avenirBold(fontSize: 22), NSForegroundColorAttributeName: UIColor.whiteColor() ]
        
    }
    
    func setupBarButtonItemAppearance() {
        let appearance = UIBarButtonItem.appearance()
        appearance.setTitleTextAttributes([ NSFontAttributeName: UIFont.avenirBold(fontSize: 14)], forState: .Normal)
        appearance.tintColor = UIColor.whiteColor()
    }
    
    func setupSegmentedControlAppearance() {
        let attributes = [NSFontAttributeName: UIFont.avenirBold(fontSize: 12)]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, forState: .Normal)
    }
}

