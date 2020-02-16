//
//  CityListViewController.swift
//  WeatherClient
//
//  Created by George Prokopenko on 15/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import UIKit

class CityListViewController: RoutableViewController<CityListPresenting> {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    private enum Constants {
        static let ok = "OK"
        static let search = "Search"
        static let delete = "Delete"
        static let addNewCity = "Add new city"
        static let noCityFound = "No city found"
        static let tryAgain = "Please try again"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindPresenter()
        presenter.viewDidLoad()
    }

    private func bindPresenter() {
        presenter.items.addListener { [weak self] newValue in
            self?.reloadData()
        }
        presenter.isLoading.addListener { [weak self] newValue in
            newValue ? self?.spinner.startAnimating() : self?.spinner.stopAnimating()
        }
    }

    private func reloadData() {
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }

    @IBAction func addCityButtonTapped() {
        let alert = UIAlertController(title: Constants.addNewCity, message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.becomeFirstResponder()
        }

        alert.addAction(UIAlertAction(title: Constants.search, style: .default, handler: { [weak self, alert] _ in
            if let textFields = alert.textFields,
                let textField = textFields.first,
                let text = textField.text {
                self?.presenter.getWeather(for: text, completion: { success in
                    if !success {
                        self?.searchFailed()
                    }
                })
            }
        }))

        present(alert, animated: true)
    }

    private func searchFailed() {
        let alert = UIAlertController(title: Constants.noCityFound,
                                      message: Constants.tryAgain,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ok, style: .cancel))
        present(alert, animated: true)
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityTableViewCell.identifier,
            for: indexPath) as? CityTableViewCell else { return UITableViewCell() }

        if let item = presenter.items.value?[indexPath.row] {
            cell.configure(name: item.name, temp: item.currentWeather?.temperature.value)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive,
                                          title: Constants.delete) { [weak self] _, _ in
                                            self?.presenter.removeCity(at: indexPath.row)
        }
        return [action]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let city = presenter.items.value?[indexPath.row] {
            router.go(to: .forecast(for: city), from: self)
        }
    }
}
