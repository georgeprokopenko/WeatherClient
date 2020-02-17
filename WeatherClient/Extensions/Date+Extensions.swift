//
//  Date+Extensions.swift
//  WeatherClient
//
//  Created by George Prokopenko on 17/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

extension Date {
    var dayOfWeek: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    var shortDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: self)
    }
    
    static func dateFromString(string: String?) -> Date? {
        guard let dateString = string else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
}
