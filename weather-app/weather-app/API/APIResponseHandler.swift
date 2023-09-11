//
//  APIResponseHandler.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

protocol APIResponseHandlerProtocol: AnyObject {
    func parsedResponse<T: Decodable>(data: Data) -> Result<T, ActionError>
}

final class APIResponseHandler: APIResponseHandlerProtocol {
    func parsedResponse<T: Decodable>(data: Data) -> Result<T, ActionError> {
        let parsedResponseData = data.decoded() as Result<T, ActionError>
        switch parsedResponseData {
        case .success(let apiResponse):
            return .success(apiResponse)
        case .failure(let parserError):
            NSLog("Can't parse APIResponse \(T.self): \(parserError.errorMessage)")
            return .failure(parserError)
        }
    }
}
