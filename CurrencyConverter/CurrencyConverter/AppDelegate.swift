//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Antonio Ruffolo on 06/08/2019.
//  Copyright © 2019 AR. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var appCoordinator: AppCoordinator!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    if let rootViewController = window?.rootViewController as? CurrencyConverterViewProtocol
    {
        appCoordinator = AppCoordinator(rootViewController: rootViewController)
    }
    
    return true
  }
}
