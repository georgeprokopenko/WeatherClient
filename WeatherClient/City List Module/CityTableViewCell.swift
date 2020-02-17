//
//  CityTableViewCell.swift
//  WeatherClient
//
//  Created by George Prokopenko on 15/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    static let identifier = "CityTableViewCell"
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var tempLabel: UILabel!
    
    func configure(name: String, temp: Double?) {
        nameLabel.text = name
        tempLabel.text = TemperatureFormatter.readableTemp(from: temp)
    }
}
