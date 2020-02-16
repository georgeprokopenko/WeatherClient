//
//  WCAPIWeatherData.swift
//  WeatherClient
//
//  Created by Georgii Prokopenko on 2/16/20.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

struct WCAPIWeatherMainData: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct WCAPIWeatherCondition: Codable {
    let main: String
    let description: String
}
