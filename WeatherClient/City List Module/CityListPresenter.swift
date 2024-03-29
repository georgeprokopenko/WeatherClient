//
//  CityListPresenter.swift
//  WeatherClient
//
//  Created by George Prokopenko on 16/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation

protocol CityListPresenting: BasePresenter {
    var items: Property<[WeatherCity]?> { get }
    var isLoading: Property<Bool> { get }

    func viewDidLoad()
    func getWeather(for cityName: String, completion: ((_ success: Bool) -> Void)?)
    func removeCity(at index: Int)
}

class CityListPresenter: CityListPresenting {
    var items = Property<[WeatherCity]?>([])
    var isLoading = Property<Bool>(false)

    private enum Constants {
        static let preloadedCities = ["Moscow", "Bangkok"]
    }
    
    func viewDidLoad() {
        preloadCities()
        updateWeatherForSavedCities()
    }

    func getWeather(for cityName: String, completion: ((_ success: Bool) -> Void)?) {
        isLoading.value = true
        networkService.fetchCurrentWeather(for: cityName) { [weak self] response in
            self?.isLoading.value = false

            if let response = response {
                let city = WeatherCity(with: response)
                self?.databaseService.saveObject(city)

                if let items = self?.items.value, !items.contains(city) {
                    self?.items.value?.insert(city, at: 0)
                }
                
            }
            completion?(response != nil)
        }
    }

    func removeCity(at index: Int) {
        if let object = items.value?[index] {
            databaseService.removeObject(object)
            items.value?.remove(at: index)
        }
    }
    
    // MARK: Private

    private func preloadCities() {
        if UserDefaults.isFirstLaunch() {
            Constants.preloadedCities.forEach(
                { databaseService.saveObject( WeatherCity(name: $0) )})
        }
    }
    
    private func updateWeatherForSavedCities() {
        guard let storedCities = databaseService.savedObjects(type: WeatherCity.self) else { return }

        for city in storedCities {
            getWeather(for: city.name, completion: { [weak self] _ in
                if city == storedCities.last {
                    self?.loadSavedCities()
                }
            })
        }
    }

    private func loadSavedCities() {
        items.value = databaseService.savedObjects(type: WeatherCity.self)?.reversed()
    }

    required init(serviceFactory: ServiceFactory) {
        self.databaseService = serviceFactory.databaseService()
        self.networkService = serviceFactory.networkService()
    }
    
    private var databaseService: DatabaseServicing
    private var networkService: NetworkServicing
}
