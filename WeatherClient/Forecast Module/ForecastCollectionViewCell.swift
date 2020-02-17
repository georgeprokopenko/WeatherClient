//
//  ForecastCollectionViewCell.swift
//  WeatherClient
//
//  Created by George Prokopenko on 17/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    static let identifier = "ForecastCollectionViewCell"
    
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var tempLabel: UILabel!
    @IBOutlet private var conditionLabel: UILabel!
    
    func configure(day: String?, date: String?, temp: Double?, condition: String?) {
        tempLabel.text = TemperatureFormatter.readableTemp(from: temp)
        conditionLabel.text = condition
        dateLabel.text = date
        dayLabel.text = day
    }
}
