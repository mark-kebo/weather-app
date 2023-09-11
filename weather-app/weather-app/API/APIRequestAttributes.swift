//
//  APIRequestAttributes.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

enum RequestMethod: String {
    case GET
    case POST
    case DELETE
}

struct APIRequestAttributes {
    let endpoint: APIEndpoint
    let method: RequestMethod
    let params: [String: Any]
}
