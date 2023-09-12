//
//  APIResponse.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

// MARK: - WeatherDetail
struct WeatherDetail: Codable {
    let coord: WeatherDetailCoord?
    let visibility: Int?
    let weather: [WeatherDetailConditions]?
    let wind: WeatherDetailWind?
    let clouds: WeatherDetailClouds?
    let main: WeatherDetailMain?
    let id: Int?
    let name: String?
    let cod: Int?
    let dt: Double?
}

struct WeatherDetailConditions: Codable {
    let id: Int?
    let main: String?
    let icon: WeatherDetailIcon?
}

// MARK: - Coord
struct WeatherDetailCoord: Codable {
    let lon, lat: Double?
}
    
// MARK: - Main
struct WeatherDetailMain: Codable {
    let temp: Double?
    let pressure, humidity: Int?
    let tempMin, tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Clouds
struct WeatherDetailClouds: Codable {
    let all: Int?
}

// MARK: - Wind
struct WeatherDetailWind: Codable {
    let speed: Double?
    let deg: Int?
}

enum WeatherDetailIcon: String, Codable {
    case clearSky = "01d"
    case fewClouds = "02d"
    case scatteredClouds = "03d"
    case brokenClouds = "04d"
    case showerRain = "09d"
    case rain = "10d"
    case thunderstorm = "11d"
    case snow = "13d"
    case mist = "50d"
    
    case clearSkyN = "01n"
    case fewCloudsN = "02n"
    case scatteredCloudsN = "03n"
    case brokenCloudsN = "04n"
    case showerRainN = "09n"
    case rainN = "10n"
    case thunderstormN = "11n"
    case snowN = "13n"
    case mistN = "50n"

    var icon: UIImage? {
        switch self {
        case .clearSky:
            return UIImage(systemName: "sun.min")
        case .fewClouds, .scatteredClouds, .brokenClouds:
            return UIImage(systemName: "cloud.sun")
        case .showerRain, .rain:
            return UIImage(systemName: "cloud.rain")
        case .thunderstorm, .thunderstormN:
            return UIImage(systemName: "cloud.bolt")
        case .snow, .snowN:
            return UIImage(systemName: "cloud.snow")
        case .mist, .mistN:
            return UIImage(systemName: "cloud.fog")
        case .clearSkyN:
            return UIImage(systemName: "moon.stars")
        case .fewCloudsN, .scatteredCloudsN, .brokenCloudsN:
            return UIImage(systemName: "cloud.moon")
        case .showerRainN, .rainN:
            return UIImage(systemName: "cloud.moon.rain")
        }
    }
}
