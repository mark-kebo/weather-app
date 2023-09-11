//
//  AppConstants.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

struct AppConstants {
    static let apiPath = "https://api.openweathermap.org/data/2.5"
    static let apiKey = "cf0f31ab062ee5159fbd1c1c41a7057a"
    static let sessionTimeoutIntervalSec: Double = 10
    
    static let searchRegex = "^[\\s\\p{L}]+$"
}
