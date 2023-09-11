//
//  CityWeatherDetailsViewController.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

final class CityWeatherDetailsViewController<ViewModel>: UIViewController where ViewModel: CityWeatherDetailsViewModelProtocol {
    
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: CityWeatherDetailsViewController.nibName,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
