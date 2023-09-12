//
//  APIRequestServiceMOCK.swift
//  weather-appTests
//
//  Created by Dima Worożbicki on 12/09/2023.
//

import Foundation
import Combine
@testable import weather_app

class APIRequestServiceMOCK: APIRequestServiceProtocol {
    
    var resultSuccess: [Decodable]?
    let resultFailure: ActionError = .network("Mock error message")
    
    func sendAPIRequest<T: Decodable>(webService: WebService, _: T.Type) -> AnyPublisher<T, ActionError> {
        if let resultSuccess = resultSuccess?.first(where: { $0 is T }) as? T {
            return Just(resultSuccess)
                .setFailureType(to: ActionError.self)
                .eraseToAnyPublisher()
        } else if let resultError = resultSuccess?.first(where: { $0 is ApiError }) as? ApiError {
            return Fail(error: .network(resultError.message))
                .eraseToAnyPublisher()
        } else {
            return Fail(error: resultFailure)
                .eraseToAnyPublisher()
        }
    }
}
