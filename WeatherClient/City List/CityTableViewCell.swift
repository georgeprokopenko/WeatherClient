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
    @IBOutlet private var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(name: String, temp: String, time: String) {
        nameLabel.text = name
        tempLabel.text = temp
        timeLabel.text = time
    }

}
