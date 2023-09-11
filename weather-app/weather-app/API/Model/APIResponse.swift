//
//  APIResponse.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let status: Int
    let data: T?
    let error: Bool
}
