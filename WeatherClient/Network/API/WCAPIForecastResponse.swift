//
//  WCAPIForecastResponse.swift
//  WeatherClient
//
//  Created by Georgii Prokopenko on 2/16/20.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

struct WCAPIForecastResponse: Codable {
    let list: [WCAPIWeatherResponse]
    let city: String

    private enum CodingKeys: String, CodingKey {
        case list
        case city
    }

    private enum CityCodingKeys: String, CodingKey {
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try container.nestedContainer(keyedBy: CityCodingKeys.self, forKey: .city)
        list = try container.decode([WCAPIWeatherResponse].self, forKey: .list)
        city = try nestedContainer.decode(String.self, forKey: .name)
    }
}

struct WCAPIForecastCity: Codable {
    let name: String
}

struct WCAPIForecast_Item: Codable {
    let date: String?
    let main: WCAPIWeatherMainData
    let weather: [WCAPIWeatherCondition]

    private enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case main
        case weather
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try? container.decode(String.self, forKey: .date)
        main = try container.decode(WCAPIWeatherMainData.self, forKey: .main)
        weather = try container.decode([WCAPIWeatherCondition].self, forKey: .weather)
    }
}
