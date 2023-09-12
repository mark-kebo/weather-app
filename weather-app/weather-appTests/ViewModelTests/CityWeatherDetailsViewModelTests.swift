//
//  CityWeatherDetailsViewModelTests.swift
//  weather-appTests
//
//  Created by Dima Worożbicki on 12/09/2023.
//

import XCTest
@testable import weather_app

class CityWeatherDetailsViewModelTests: XCTestCase {
    
    private var model: CityWeatherDetailsViewModelProtocol?
    private let coordinator = CoordinatorMock()
    private let requestService = APIRequestServiceMOCK()
    private let successKrakowModel = WeatherDetail(coord: nil, visibility: 10,
                                                   weather: [], wind: nil,
                                                   clouds: nil, main: nil,
                                                   id: 1, name: "Krakow", cod: 1, dt: 11)
    private var successForecastModel: WeatherForecast { WeatherForecast(list: [successKrakowModel, successKrakowModel]) }
    private let errorModel = ApiError(cod: "404", message: "Some error")
    
    override func setUpWithError() throws {
        model = CityWeatherDetailsViewModel(coordinator: coordinator,
                                            city: "Krakow",
                                            details: successKrakowModel,
                                            apiService: requestService)
    }
    
    override func tearDownWithError() throws {
        model = nil
    }

    func testGetViewDataSuccess() throws {
        requestService.resultSuccess = [successKrakowModel, successForecastModel]
        Task {
            await model?.updateData()
            XCTAssertEqual(model?.viewData.count, 3)
            XCTAssertEqual(model?.viewData.first?.details?.name, successKrakowModel.name)
        }
    }

    func testGetViewDataApiError() throws {
        requestService.resultSuccess = [errorModel]
        let expectations = XCTestExpectation()
        coordinator.expectations = expectations
        Task {
            await model?.updateData()
        }
        wait(for:[expectations], timeout: 2.0)
        XCTAssertEqual(coordinator.error?.errorMessage, errorModel.message)
    }

    func testGetViewDataFail() throws {
        let expectations = XCTestExpectation()
        coordinator.expectations = expectations
        Task {
            await model?.updateData()
        }
        wait(for:[expectations], timeout: 2.0)
        XCTAssertEqual(coordinator.error?.errorMessage, requestService.resultFailure.errorMessage)
    }
}

fileprivate class CoordinatorMock: CityWeatherDetailsCoordinatorProtocol {
    var expectations: XCTestExpectation?
    var error: ActionError?
    var rootNavigationController: UINavigationController?
    func start() {}
    
    func showError(_ error: ActionError) {
        self.error = error
        expectations?.fulfill()
        expectations = nil
    }
}
