//
//  NetworkService.swift
//  WeatherClient
//
//  Created by George Prokopenko on 16/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

typealias CurrentWeatherResponse = (WCAPIWeatherResponse?) -> Void
typealias ForecastResponse = (WCAPIForecastResponse?) -> Void

protocol NetworkServicing {
    func fetchCurrentWeather(for cityName: String, completion: @escaping CurrentWeatherResponse)
    func fetchForecast(for cityName: String, completion: @escaping ForecastResponse)
}

class NetworkService: NetworkServicing {
    let provider = NetworkProvider<WeatherAPI>()

    func fetchCurrentWeather(for cityName: String, completion: @escaping CurrentWeatherResponse) {
        provider.request(.loadCurrentWeather(for: cityName),
                         responseType: WCAPIWeatherResponse.self) { result, error in
                            completion(result)
        }
    }

    func fetchForecast(for cityName: String, completion: @escaping ForecastResponse) {
        provider.request(.loadForecast(for: cityName),
                         responseType: WCAPIForecastResponse.self) { result, error in
                            completion(result)
        }
    }
}
