//
//  CityWeatherDetailsForecastTableViewCell.swift
//  weather-app
//
//  Created by Dima Worożbicki on 12/09/2023.
//

import UIKit

final class CityWeatherDetailsForecastTableViewCell: UITableViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
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
        dateLabel.text = viewData?.dateString
    }
}
