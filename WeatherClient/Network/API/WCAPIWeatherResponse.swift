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
    let date: String?
    let main: WCAPIWeatherMainData
    let weather: [WCAPIWeatherCondition]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case date = "dt_txt"
        case main
        case weather
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)
        date = try? container.decode(String.self, forKey: .date)
        main = try container.decode(WCAPIWeatherMainData.self, forKey: .main)
        weather = try container.decode([WCAPIWeatherCondition].self, forKey: .weather)
    }
}
