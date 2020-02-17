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
    @IBOutlet private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindPresenter()
        presenter.viewDidLoad()
    }

    private func bindPresenter() {
        presenter.item.addListener(skipCurrent: true) { [weak self] item in
            self?.cityNameLabel.text = item?.name
            self?.conditionLabel.text = item?.currentWeather?.conditionName
            self?.temperatureLabel.text = TemperatureFormatter.readableTemp(
                                            from: item?.currentWeather?.temperature.value)
        }
        
        presenter.forecastItems.addListener(skipCurrent: true) { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }
}

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.forecastItems.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ForecastCollectionViewCell.identifier,
            for: indexPath) as? ForecastCollectionViewCell else { return UICollectionViewCell() }
        
        let item = presenter.forecastItems.value[indexPath.row]
        cell.configure(day: item.date.dayOfWeek,
        date: item.date.shortDate,
        temp: item.temperature.value,
        condition: item.conditionName)
        
        return cell
    }
}
