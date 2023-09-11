//
//  CitySearchItem.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

struct CitySearchSection {
    let header: String
    let items: [CitySearchItem]
}

struct CitySearchItem {
    var id: Int?
    var text: String
    let details: WeatherDetail?
    
    init(weatherDetail: WeatherDetail) {
        self.text = weatherDetail.name ?? ""
        self.details = weatherDetail
        guard let temp = weatherDetail.main?.temp else { return }
        self.text += ": \(temp) °C"
    }
    
    init?(id: Int?, city: String?) {
        guard let city else { return nil }
        self.text = city
        self.id = id
        self.details = nil
    }
}
