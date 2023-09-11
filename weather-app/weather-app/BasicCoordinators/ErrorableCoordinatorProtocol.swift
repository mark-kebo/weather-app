//
//  ErrorableCoordinatorProtocol.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

protocol ErrorableCoordinatorProtocol: CoordinatorProtocol {
    func showError(_ error: ActionError)
}

extension ErrorableCoordinatorProtocol {
    func showError(_ error: ActionError) {
        NSLog("Show error: \(error.errorTitle) - \(error.errorMessage)")
        DispatchQueue.main.async {
            let alert = UIAlertController(title: error.errorTitle,
                                          message: error.errorMessage,
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ActionClose".localized,
                                          style: UIAlertAction.Style.default, handler: nil))
            self.rootNavigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
