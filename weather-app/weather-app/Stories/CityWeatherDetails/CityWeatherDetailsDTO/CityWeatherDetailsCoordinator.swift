//
//  CityWeatherDetailsCoordinator.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

protocol CityWeatherDetailsCoordinatorProtocol: CoordinatorProtocol {}

final class CityWeatherDetailsCoordinator: CityWeatherDetailsCoordinatorProtocol {
    private let city: String, details: WeatherDetail?
    weak var rootNavigationController: UINavigationController?
    
    deinit {
        NSLog("\(self) deinited")
    }
    
    init(rootNavigationController: UINavigationController?,
         city: String, details: WeatherDetail?) {
        self.rootNavigationController = rootNavigationController
        self.city = city
        self.details = details
    }
    
    func start() {
        let viewModel = CityWeatherDetailsViewModel(coordinator: self, city: city, details: details)
        let viewController = CityWeatherDetailsViewController(viewModel: viewModel)
        rootNavigationController?.pushViewController(viewController, animated: true)
    }
}
