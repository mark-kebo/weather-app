//
//  APIResponse.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

// MARK: - WeatherDetail
struct WeatherDetail: Codable {
    let coord: WeatherDetailCoord?
    let weather: [WeatherDetailInfo]?
    let main: WeatherDetailMain?
    let id: Int?
    let name: String?
    let cod: Int?
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

// MARK: - Weather
struct WeatherDetailInfo: Codable {
    let id: Int?
    let main, description, icon: String?
}
