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
    var forecastItems: Property<[WeatherData]> { get }
    func configure(with city: WeatherCity)
}

class ForecastPresenter: ForecastPresenting {
    var item = Property<WeatherCity?>(nil)
    var forecastItems = Property<[WeatherData]>([])
    private var selectedCity: WeatherCity?
    
    func configure(with city: WeatherCity) {
        selectedCity = city
        loadForecast(for: city)
    }

    func viewDidLoad() {
        item.value = selectedCity
    }

    //MARK: Private

    private enum Constants {
        static let maximumForecastItems = 7
    }
    
    private func loadForecast(for city: WeatherCity) {
        networkService.fetchForecast(for: city.name) { [weak self, city] response in
            self?.databaseService.modify {
                response?.list.forEach { city.forecast.append(WeatherData(with: $0)) }
                self?.item.value = city
                self?.processForecast()
            }
        }
    }
    
    private func processForecast() {
        guard let item = item.value, !item.forecast.isEmpty else { return }
        var uniqueDays = [Date]()
        
        for object in item.forecast {
            let startOfDay = Calendar.current.startOfDay(for: object.date)
            if !uniqueDays.contains(startOfDay) {
                uniqueDays.append(startOfDay)
                if forecastItems.value.count <= Constants.maximumForecastItems {
                    forecastItems.value.append(object)
                }
            }
        }
    }

    required init(serviceFactory: ServiceFactory) {
        self.networkService = serviceFactory.networkService()
        self.databaseService = serviceFactory.databaseService()
    }

    private var networkService: NetworkServicing
    private var databaseService: DatabaseServicing
}
