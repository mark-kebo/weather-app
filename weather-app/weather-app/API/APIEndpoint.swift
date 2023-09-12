//
//  APIEndpoint.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

enum APIEndpoint: String {
    case weather = "/weather"
    case forecast = "/forecast"
}

enum WebService {
    case getWeather(city: String, endpoint: APIEndpoint)
}

extension WebService {
    var attributes: APIRequestAttributes {
        switch self {
        case .getWeather(let city, let endpoint):
            let params: [String : Any] = [
                "appid": AppConstants.apiKey,
                "q": city,
                "units": "metric"
            ]
            return APIRequestAttributes(endpoint: endpoint,
                                        method: .GET,
                                        params: params)
        }
    }
}
