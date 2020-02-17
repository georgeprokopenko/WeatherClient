//
//  BasePresenter.swift
//  WeatherClient
//
//  Created by George Prokopenko on 16/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

protocol BasePresenter {
    init(serviceFactory: ServiceFactory)
    
    func viewDidLoad()
}
