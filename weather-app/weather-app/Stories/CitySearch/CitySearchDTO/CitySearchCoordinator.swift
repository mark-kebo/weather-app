//
//  CitySearchCoordinator.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

protocol CitySearchCoordinatorProtocol: ErrorableCoordinatorProtocol {
    func navigateToCityDetails(with item: CitySearchItem)
}


final class CitySearchCoordinator: CitySearchCoordinatorProtocol {
    weak var rootNavigationController: UINavigationController?
    
    deinit {
        NSLog("\(self) deinited")
    }
    
    init(rootNavigationController: UINavigationController?) {
        self.rootNavigationController = rootNavigationController
    }
    
    func start() {
        let viewModel = CitySearchViewModel(coordinator: self)
        let viewController = CitySearchViewController(viewModel: viewModel)
        rootNavigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToCityDetails(with item: CitySearchItem) {
        CityWeatherDetailsCoordinator(rootNavigationController: rootNavigationController,
                                      city: item.details?.name ?? item.text,
                                      details: item.details).start()
    }
}
