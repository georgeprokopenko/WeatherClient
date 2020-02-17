//
//  TemperatureFormatter.swift
//  WeatherClient
//
//  Created by George Prokopenko on 17/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

class TemperatureFormatter {
    static func readableTemp(from number: Double?) -> String {
        if let number = number {
            return "\(Int(floor(number)))°"
        } else {
            return "--"
        }
    }
}
