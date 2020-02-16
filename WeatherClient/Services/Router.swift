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
    case forecast
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
        case .forecast:
            print()
            //controller = detailModule(character)
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
        module.viewModel = SearchViewModel(serviceFactory: serviceFactory)
        searchModule.router = self
        return searchModule
    }

    private func detailModule(_ object: Character) -> DetailViewController {
        let detailModule = DetailViewController.instantiateFromStoryboard()
        detailModule.viewModel = DetailViewModel(character: object)
        detailModule.router = self
        return detailModule
    }
    
    private var window: UIWindow!
    private func configureWindow(with rootController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: rootController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
