//
//  CityWeatherDetailsViewModel.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

protocol CityWeatherDetailsViewModelProtocol {
    var title: String { get }
}

final class CityWeatherDetailsViewModel<Coordinator>: CityWeatherDetailsViewModelProtocol where Coordinator: CityWeatherDetailsCoordinatorProtocol {
    private var coordinator: Coordinator
    private var details: WeatherDetail?
    var title: String
    
    init(coordinator: Coordinator,
         city: String, details: WeatherDetail?) {
        self.coordinator = coordinator
        self.title = city
        self.details = details
    }
}
