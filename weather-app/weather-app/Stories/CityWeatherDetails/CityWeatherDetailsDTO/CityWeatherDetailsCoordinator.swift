//
//  CityWeatherDetailsCoordinator.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

protocol CityWeatherDetailsCoordinatorProtocol: CoordinatorProtocol {
}


final class CityWeatherDetailsCoordinator: CityWeatherDetailsCoordinatorProtocol {
    weak var rootNavigationController: UINavigationController?
    
    deinit {
        NSLog("\(self) deinited")
    }
    
    init(rootNavigationController: UINavigationController?) {
        self.rootNavigationController = rootNavigationController
    }
    
    func start() {
        let viewModel = CityWeatherDetailsViewModel(coordinator: self)
        let viewController = UINavigationController(rootViewController: CityWeatherDetailsViewController(viewModel: viewModel))
        rootNavigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
