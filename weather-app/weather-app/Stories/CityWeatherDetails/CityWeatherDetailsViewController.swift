//
//  CityWeatherDetailsViewController.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

final class CityWeatherDetailsViewController: UIViewController {
    
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
//        viewModel.delegate = self
        navigationItem.title = viewModel.title
    }
}
