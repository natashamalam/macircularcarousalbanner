//
//  AppDelegate.swift
//  MACircularCarousalBanner
//
//  Created by Alam, Mahjabin | Natasha | ECMPD on 2022/11/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DemoViewController()
        window?.makeKeyAndVisible()
        return true
    }


}

