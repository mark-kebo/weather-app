//
//  CityWeatherDetailsViewModel.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation
import Combine

protocol CityWeatherDetailsViewModelProtocol {
    var title: String { get }
    var viewData: [CityWeatherDetailsItem] { get }
    func updateData() async
}

final class CityWeatherDetailsViewModel<Coordinator>: CityWeatherDetailsViewModelProtocol where Coordinator: CityWeatherDetailsCoordinatorProtocol {
    private var coordinator: Coordinator
    private var details: CityWeatherDetailsItem
    private var forecastViewData: [CityWeatherDetailsItem] = []
    private let apiService: APIRequestServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    var title: String
    var viewData: [CityWeatherDetailsItem] {
        guard details.details != nil else { return [] }
        return [details] + forecastViewData
    }
    
    init(coordinator: Coordinator,
         city: String, details: WeatherDetail?,
         apiService: APIRequestServiceProtocol = APIRequestService()) {
        self.coordinator = coordinator
        self.apiService = apiService
        self.title = city
        self.details = CityWeatherDetailsItem(isForecast: false, details: details)
    }
    
    func updateData() async {
        details = await getCurrentData()
        forecastViewData = await getForecastData()
    }
    
    private func getCurrentData() async -> CityWeatherDetailsItem {
        NSLog("Get current data")
        return await withCheckedContinuation { continuation in
            apiService.sendAPIRequest(webService: .getWeather(city: title, endpoint: .weather), WeatherDetail.self)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.coordinator.showError(error)
                }
            } receiveValue: { result in
                continuation.resume(with: .success(CityWeatherDetailsItem(isForecast: false, details: result)))
            }
            .store(in: &self.cancellables)
        }
    }
    
    private func getForecastData() async -> [CityWeatherDetailsItem] {
        NSLog("Get forecast data")
        return await withCheckedContinuation { continuation in
            apiService.sendAPIRequest(webService: .getWeather(city: title, endpoint: .forecast), WeatherForecast.self)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.coordinator.showError(error)
                    continuation.resume(with: .success([]))
                }
            } receiveValue: { result in
                let forecast = result.list?.compactMap { CityWeatherDetailsItem(isForecast: true, details: $0) }
                continuation.resume(with: .success(forecast ?? []))
            }
            .store(in: &self.cancellables)
        }
    }
}
