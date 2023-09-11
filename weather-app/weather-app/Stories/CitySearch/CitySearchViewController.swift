//
//  CitySearchViewController.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

final class CitySearchViewController<ViewModel>: UIViewController where ViewModel: CitySearchViewModelProtocol {
    
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: CitySearchViewController.nibName,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
