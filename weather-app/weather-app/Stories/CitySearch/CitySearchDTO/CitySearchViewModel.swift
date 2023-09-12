//
//  CitySearchViewModel.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation
import Combine

protocol CitySearchViewModelProtocol {
    var delegate: CitySearchViewModelDelegate? { get set }
    var viewData: [CitySearchSection] { get }
    func getViewData(for searchText: String)
    func prepareSearchDetails(for indexPath: IndexPath)
    func deleteLastCity(by id: Int)
}

protocol CitySearchViewModelDelegate: AnyObject {
    func errorReceived(_ message: String)
    func viewDataUpdated()
}

final class CitySearchViewModel<Coordinator>: CitySearchViewModelProtocol where Coordinator: CitySearchCoordinatorProtocol {
    private let coordinator: Coordinator
    private let apiService: APIRequestServiceProtocol
    private let realmManager: RealmManagerProtocol
    private var cancellables: Set<AnyCancellable> = []
    private var searchSection: CitySearchSection?
    
    var viewData: [CitySearchSection] {
        var viewData: [CitySearchSection] = []
        if let searchSection {
            viewData.append(searchSection)
        }
        if let entities = realmManager.readAllOfType(WeatherDetailEntity.self)?.reversed(),
           !entities.isEmpty {
            viewData.append(CitySearchSection(header: "LastCitySectionHeader".localized,
                                              items: entities.compactMap({ CitySearchItem(id: $0.id, city: $0.name) })))
        }
        return viewData
    }
    
    weak var delegate: CitySearchViewModelDelegate?

    init(coordinator: Coordinator,
         realmManager: RealmManagerProtocol = RealmManager(),
         apiService: APIRequestServiceProtocol = APIRequestService()) {
        self.coordinator = coordinator
        self.apiService = apiService
        self.realmManager = realmManager
    }
    
    func getViewData(for searchText: String) {
        NSLog("Get weather data for: \(searchText)")
        apiService.sendAPIRequest(webService: .getWeather(city: searchText, endpoint: .weather), WeatherDetail.self)
        .sink { [weak self] completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self?.searchSection = nil
                DispatchQueue.main.async {
                    self?.delegate?.errorReceived(error.errorMessage)
                }
            }
        } receiveValue: { [weak self] result in
            self?.updateViewData(weatherDetail: result)
        }
        .store(in: &self.cancellables)
    }
    
    func prepareSearchDetails(for indexPath: IndexPath) {
        coordinator.navigateToCityDetails(with: viewData[indexPath.section].items[indexPath.row])
    }
    
    func deleteLastCity(by id: Int) {
        guard let entity = realmManager.readAllOfType(WeatherDetailEntity.self)?.first(where: { $0.id == id }) else { return }
        realmManager.delete(entity)
    }
    
    private func updateViewData(weatherDetail: WeatherDetail) {
        searchSection = CitySearchSection(header: "CitySectionHeader".localized,
                                          items: [CitySearchItem(weatherDetail: weatherDetail)])
        DispatchQueue.main.async {
            self.delegate?.viewDataUpdated()
        }
        realmManager.create(WeatherDetailEntity(weatherDetail: weatherDetail))
    }
}
