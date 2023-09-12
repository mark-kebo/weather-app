//
//  CityWeatherDetailsItem.swift
//  weather-app
//
//  Created by Dima Worożbicki on 12/09/2023.
//

import UIKit

struct CityWeatherDetailsItem {
    var isForecast: Bool
    var details: WeatherDetail?
    
    var dateString: String? {
        guard let unixtimeInterval = details?.dt else { return nil }
        let date = Date(timeIntervalSince1970: unixtimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM HH:mm"
        return dateFormatter.string(from: date)
    }
    
    var fontColor: UIColor? {
        guard let temp = details?.main?.temp else { return UIColor.black }
        if temp > 20 {
            return UIColor.red
        } else if temp < 10 {
            return UIColor.blue
        } else {
            return UIColor.black
        }
    }
}
