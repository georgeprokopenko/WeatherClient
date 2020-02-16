//
//  WeatherAPI.swift
//  WeatherClient
//
//  Created by George Prokopenko on 16/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation
import Moya

typealias WCAPIResponseBlock<T> = ((T?, SWError?) -> ()) where T: Codable

enum WeatherAPI {
    case loadCurrentWeather(for: String)
    case loadForecast(for: String)
}

extension WeatherAPI: TargetType {
    fileprivate enum Constants {
        static let baseUrl = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "78a5cd9466debbaea0efcbbd469019f1"
    }

    var baseURL: URL { return URL(string: Constants.baseUrl)! }
    var method: Moya.Method { return .get }
    var sampleData: Data { return Data() }

    var path: String {
        switch self {
        case .loadCurrentWeather: return "weather"
        case .loadForecast: return "forecast"
        }
    }

    var task: Task {
        switch self {
        case .loadCurrentWeather(let string), .loadForecast(let string):
            return .requestParameters(parameters: ["q": string,
                                                   "appid": Constants.apiKey,
                                                   "units" : "metric"],
                                      encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
}

extension WeatherAPI: MoyaCacheable {
    var cachePolicy: MoyaCacheablePolicy {
        return .reloadIgnoringCacheData
    }
}
