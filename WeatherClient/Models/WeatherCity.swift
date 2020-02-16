//
//  WeatherCity.swift
//  WeatherClient
//
//  Created by Georgii Prokopenko on 2/16/20.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherData: Object {
    let temperature = RealmOptional<Double>()
    let pressure = RealmOptional<Int>()
    let humidity = RealmOptional<Int>()
    @objc dynamic var conditionName: String = ""
    @objc dynamic var conditionDescription: String = ""

    convenience init(with response: WCAPIWeatherResponse) {
        self.init()
        self.temperature.value = response.main.temp
        self.pressure.value = response.main.pressure
        self.humidity.value = response.main.humidity
        self.conditionName = response.weather.first?.main ?? ""
        self.conditionDescription = response.weather.first?.description ?? ""
    }
}

class WeatherCity: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var currentWeather: WeatherData?
    dynamic var forecast = List<WeatherData>()

    override class func primaryKey() -> String? {
        return "name"
    }

    convenience init(with response: WCAPIWeatherResponse) {
        self.init()
        self.name = response.name ?? ""
        self.currentWeather = WeatherData(with: response)
    }
}
