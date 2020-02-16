//
//  ServiceFactory.swift
//  WeatherClient
//
//  Created by George Prokopenko on 16/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation
import RealmSwift

class ServiceFactory {
    func networkService() -> NetworkService {
        return NetworkService()
    }
    
    func databaseService() -> DatabaseService {
        return DatabaseService()
    }
}
