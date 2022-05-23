//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 22/05/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    static func getInstance() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }

}

