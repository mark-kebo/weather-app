//
//  CityWeatherDetailsViewModel.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

protocol CityWeatherDetailsViewModelProtocol {
}

final class CityWeatherDetailsViewModel<Coordinator>: CityWeatherDetailsViewModelProtocol where Coordinator: CityWeatherDetailsCoordinatorProtocol {
    private var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}
