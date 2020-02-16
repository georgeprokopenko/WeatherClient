//
//  BaseViewController.swift
//  WeatherClient
//
//  Created by George Prokopenko on 16/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import UIKit

class RoutableViewController<T>: UIViewController, UIScrollViewDelegate {
    var presenter: T!
    var router: Router!
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
