//
//  UserDefaults+Extensions.swift
//  WeatherClient
//
//  Created by George Prokopenko on 17/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "FirstLaunchFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: firstLaunchFlag)
        
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
