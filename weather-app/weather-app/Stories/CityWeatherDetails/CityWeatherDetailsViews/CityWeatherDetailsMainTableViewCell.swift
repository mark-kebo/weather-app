//
//  CityWeatherDetailsMainTableViewCell.swift
//  weather-app
//
//  Created by Dima Worożbicki on 12/09/2023.
//

import UIKit

final class CityWeatherDetailsMainTableViewCell: UITableViewCell {
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var visibilityLabel: UILabel!
    
    var viewData: CityWeatherDetailsItem? {
        didSet {
            fillViews()
        }
    }
    
    private func fillViews() {
        iconImageView.tintColor = viewData?.fontColor
        tempLabel.textColor = viewData?.fontColor
        iconImageView.image = viewData?.details?.weather?.first?.icon?.icon
        tempLabel.text = "\(viewData?.details?.main?.temp ?? 0)°"
        pressureLabel.text = "CityWeatherPressure".localized + "\(viewData?.details?.main?.pressure ?? 0)"
        humidityLabel.text = "CityWeatherHumidity".localized + "\(viewData?.details?.main?.humidity ?? 0)"
        windSpeedLabel.text = "CityWeatherWindSpeed".localized + "\(viewData?.details?.wind?.speed ?? 0)"
        visibilityLabel.text = "CityWeatherVisibility".localized + "\(viewData?.details?.visibility ?? 0)"
    }
}
