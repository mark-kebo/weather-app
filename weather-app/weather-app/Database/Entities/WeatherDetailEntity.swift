//
//  WeatherDetailEntity.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation
import RealmSwift

final class WeatherDetailEntity: Object, Codable {
    @objc dynamic var id: Int = Int.min
    @objc dynamic var name: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }

    convenience init(weatherDetail: WeatherDetail) {
        self.init()
        self.id = weatherDetail.id ?? Int.min
        self.name = weatherDetail.name

    }
}
