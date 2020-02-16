//
//  WCAPIWeatherResponse.swift
//  WeatherClient
//
//  Created by Georgii Prokopenko on 2/16/20.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

struct WCAPIWeatherResponse: Codable {
    let name: String?
    let main: WCAPIWeatherMainData
    let weather: [WCAPIWeatherCondition]
}
