//
//  WeatherForecast.swift
//  weather-app
//
//  Created by Dima Worożbicki on 12/09/2023.
//

import Foundation

// MARK: - WeatherForecast
struct WeatherForecast: Codable {
    let list: [WeatherDetail]?
}
