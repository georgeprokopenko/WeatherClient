//
//  AppDelegate.swift
//  WeatherClient
//
//  Created by George Prokopenko on 15/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let router = Router(serviceFactory: ServiceFactory())
        router.go(to: .cityList)

        return true
    }
    
    
}

