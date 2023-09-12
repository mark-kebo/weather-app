//
//  CityWeatherDetailsViewController.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

final class CityWeatherDetailsViewController: UIViewController {
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: CityWeatherDetailsViewModelProtocol
    
    init(viewModel: CityWeatherDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: CityWeatherDetailsViewController.nibName,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        
    }

    private func prepareViews() {
        tableView.dataSource = self
        navigationItem.title = viewModel.title
        tableView.register(UINib(nibName: CityWeatherDetailsMainTableViewCell.nibName, bundle: nil),
                           forCellReuseIdentifier: CityWeatherDetailsMainTableViewCell.nibName)
        tableView.register(UINib(nibName: CityWeatherDetailsForecastTableViewCell.nibName, bundle: nil),
                           forCellReuseIdentifier: CityWeatherDetailsForecastTableViewCell.nibName)
        loadingIndicator.startAnimating()
        Task {
            await viewModel.updateData()
            loadingIndicator.stopAnimating()
            tableView.reloadData()
        }
    }
}

extension CityWeatherDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.viewData[indexPath.row]
        if item.isForecast {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityWeatherDetailsForecastTableViewCell.nibName,
                                                           for: indexPath) as? CityWeatherDetailsForecastTableViewCell else { return UITableViewCell() }
            cell.viewData = item
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityWeatherDetailsMainTableViewCell.nibName,
                                                           for: indexPath) as? CityWeatherDetailsMainTableViewCell else { return UITableViewCell() }
            cell.viewData = item
            return cell
        }
    }
}
