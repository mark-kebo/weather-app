//
//  ApiError.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

struct ApiError: Codable {
    let cod: String
    let message: String
}
