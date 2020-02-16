//
//  Router.swift
//  WeatherClient
//
//  Created by George Prokopenko on 16/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import UIKit

enum Screen {
    case cityList
    case forecast(for: WeatherCity)
}

class Router: NSObject {
    private let serviceFactory: ServiceFactory!
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    func go(to screen: Screen, from: UIViewController? = nil) {
        var controller: UIViewController
        
        switch screen {
        case .cityList:
            controller = cityListModule()
        case .forecast(let city):
            controller = forecastModule(for: city)
        }
        
        if UIApplication.shared.keyWindow != nil {
            from?.navigationController?.pushViewController(controller, animated: true)
        } else {
            configureWindow(with: controller)
        }
    }

// MARK: Private
    
    private func cityListModule() -> CityListViewController {
        let module = CityListViewController.instantiateFromStoryboard()
        module.presenter = CityListPresenter(serviceFactory: serviceFactory)
        module.router = self
        return module
    }

    private func forecastModule(for city: WeatherCity) -> ForecastViewController {
        let module = ForecastViewController.instantiateFromStoryboard()
        module.presenter = ForecastPresenter(serviceFactory: serviceFactory)
        module.presenter.configure(with: city)
        module.router = self
        return module
    }
    
    private var window: UIWindow!
    private func configureWindow(with rootController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: rootController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
