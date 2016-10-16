//
//  AppDelegate.swift
//  Binary o'clock
//
//  Created by Home on 2016-10-12.
//  Copyright © 2016 backslashed. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Stop screen from turning off
        UIApplication.shared.isIdleTimerDisabled = true
        
        return true
    }
}
