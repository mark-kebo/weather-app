//
//  CitySearchViewModel.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

protocol CitySearchViewModelProtocol {
}

final class CitySearchViewModel<Coordinator>: CitySearchViewModelProtocol where Coordinator: CitySearchCoordinatorProtocol {
    private var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}
