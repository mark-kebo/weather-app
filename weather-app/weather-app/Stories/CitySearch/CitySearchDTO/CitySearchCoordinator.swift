//
//  CitySearchCoordinator.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

protocol CitySearchCoordinatorProtocol: ErrorableCoordinatorProtocol {
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
        let viewController = UINavigationController(rootViewController: CitySearchViewController(viewModel: viewModel))
        rootNavigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
