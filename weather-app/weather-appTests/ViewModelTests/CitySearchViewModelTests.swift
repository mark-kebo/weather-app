//
//  CitySearchViewModelTests.swift
//  weather-appTests
//
//  Created by Dima Worożbicki on 12/09/2023.
//

import XCTest
import Combine
@testable import weather_app

class CitySearchViewModelTests: XCTestCase {
    
    private var model: CitySearchViewModelProtocol?
    private let coordinator = CoordinatorMock()
    private let requestService = APIRequestServiceMOCK()
    private let realmManager = RealmManagerMOCK()
    private let viewModelClient = ViewModelMock()
    private let successKrakowModel = WeatherDetail(coord: nil, visibility: 10,
                                                   weather: [], wind: nil,
                                                   clouds: nil, main: nil,
                                                   id: 1, name: "Krakow", cod: 1, dt: 11)
    private let successLidaModel = WeatherDetail(coord: nil, visibility: 10,
                                                 weather: [], wind: nil,
                                                 clouds: nil, main: nil,
                                                 id: 2, name: "Lida", cod: 2, dt: 21)
    private let errorModel = ApiError(cod: "404", message: "Some error")
    
    override func setUpWithError() throws {
        model = CitySearchViewModel(coordinator: coordinator,
                                    realmManager: realmManager,
                                    apiService: requestService)
        model?.delegate = viewModelClient
    }
    
    override func tearDownWithError() throws {
        model = nil
    }

    func testGetViewDataSuccess() throws {
        requestService.resultSuccess = [successKrakowModel]
        let expectations = XCTestExpectation()
        viewModelClient.expectations = expectations
        model?.getViewData(for: successKrakowModel.name!)
        wait(for:[expectations], timeout: 2.0)
        XCTAssertEqual(model?.viewData.first?.items.first?.details?.name, successKrakowModel.name)
        requestService.resultSuccess = [successLidaModel]
        let expectations2 = XCTestExpectation()
        viewModelClient.expectations = expectations2
        model?.getViewData(for: successLidaModel.name!)
        wait(for:[expectations2], timeout: 2.0)
        XCTAssertEqual(model?.viewData.count, 2)
        XCTAssertEqual(model?.viewData.last?.items.first?.text, successLidaModel.name)
    }
    
    func testGetViewDataApiError() throws {
        requestService.resultSuccess = [errorModel]
        let expectations = XCTestExpectation()
        viewModelClient.expectations = expectations
        model?.getViewData(for: "")
        wait(for:[expectations], timeout: 2.0)
        XCTAssertEqual(viewModelClient.errorMessage, errorModel.message)
    }
    
    func testGetViewDataFail() throws {
        let expectations = XCTestExpectation()
        viewModelClient.expectations = expectations
        model?.getViewData(for: "")
        wait(for:[expectations], timeout: 2.0)
        XCTAssertEqual(viewModelClient.errorMessage, requestService.resultFailure.errorMessage)
    }
    
    func testDeleteLastCitySuccess() throws {
        requestService.resultSuccess = [successKrakowModel]
        let expectations = XCTestExpectation()
        viewModelClient.expectations = expectations
        model?.getViewData(for: successKrakowModel.name!)
        wait(for:[expectations], timeout: 2.0)
        XCTAssertEqual(model?.viewData.count, 2)
        model?.deleteLastCity(by: 1)
        XCTAssertEqual(model?.viewData.count, 1)
    }
    
    func testPrepareSearchDetailsSuccess() throws {
        requestService.resultSuccess = [successKrakowModel]
        let expectations = XCTestExpectation()
        viewModelClient.expectations = expectations
        model?.getViewData(for: successKrakowModel.name!)
        wait(for:[expectations], timeout: 2.0)
        let expectations2 = XCTestExpectation()
        coordinator.expectations = expectations2
        model?.prepareSearchDetails(for: IndexPath(row: 0, section: 0))
        wait(for:[expectations2], timeout: 2.0)
        XCTAssertEqual(coordinator.item?.text, successKrakowModel.name)
    }
}

fileprivate class ViewModelMock: CitySearchViewModelDelegate {
    var errorMessage: String?
    var expectations: XCTestExpectation?

    func errorReceived(_ message: String) {
        self.errorMessage = message
        expectations?.fulfill()
        expectations = nil
    }
    
    func viewDataUpdated() {
        expectations?.fulfill()
        expectations = nil
    }
}

fileprivate class CoordinatorMock: CitySearchCoordinatorProtocol {
    var rootNavigationController: UINavigationController?
    var expectations: XCTestExpectation?
    var item: CitySearchItem?

    func start() {}

    func navigateToCityDetails(with item: CitySearchItem) {
        self.item = item
        expectations?.fulfill()
        expectations = nil
    }
}
