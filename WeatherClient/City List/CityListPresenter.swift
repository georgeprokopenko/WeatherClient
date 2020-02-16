//
//  CityListPresenter.swift
//  WeatherClient
//
//  Created by George Prokopenko on 16/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

protocol CityListPresenting: BasePresenter {
    func viewDidLoad()
}

class CityListPresenter: CityListPresenting {
    
    func viewDidLoad() {
        
    }
    
    
    // MARK: Private
    
    required init(serviceFactory: ServiceFactory) {
        self.databaseService = serviceFactory.databaseService()
        self.networkService = serviceFactory.networkService()
    }
    
    private var databaseService: DatabaseService
    private var networkService: NetworkService
}
