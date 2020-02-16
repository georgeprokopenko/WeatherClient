//
//  ForecastViewController.swift
//  WeatherClient
//
//  Created by Georgii Prokopenko on 2/16/20.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import UIKit

class ForecastViewController: RoutableViewController<ForecastPresenting> {
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var conditionLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindPresenter()
        presenter.viewDidLoad()
    }

    private func bindPresenter() {
        presenter.item.addListener(skipCurrent: true) { [weak self] item in
            self?.cityNameLabel.text = item?.name
            self?.conditionLabel.text = item?.currentWeather?.conditionName

            if let temp = item?.currentWeather?.temperature.value {
                self?.temperatureLabel.text = "\(Int(floor(temp)))°"
            } else {
                self?.temperatureLabel.text = "---"
            }
        }
    }
}
