//
//  ForecastPresenter.swift
//  WeatherClient
//
//  Created by Georgii Prokopenko on 2/16/20.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

protocol ForecastPresenting: BasePresenter {
    var item: Property<WeatherCity?> { get }
    func configure(with city: WeatherCity)
}

class ForecastPresenter: ForecastPresenting {
    var item = Property<WeatherCity?>(nil)
    private var selectedCity: WeatherCity?

    func configure(with city: WeatherCity) {
        selectedCity = city
        loadForecast(for: city)
    }

    func viewDidLoad() {
        item.value = selectedCity
    }

    //MARK: Private

    private func loadForecast(for city: WeatherCity) {
        networkService.fetchForecast(for: city.name) { [weak self, city] response in
            self?.databaseService.modify {
                
                response?.list.forEach { city.forecast.append(WeatherData(with: $0)) }
            }
            self?.item.value = city
        }
    }

    required init(serviceFactory: ServiceFactory) {
        self.networkService = serviceFactory.networkService()
        self.databaseService = serviceFactory.databaseService()
    }

    private var networkService: NetworkServicing
    private var databaseService: DatabaseServicing
}
