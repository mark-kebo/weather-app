//
//  CoordinatorProtocol.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

protocol CoordinatorProtocol {
    var rootNavigationController: UINavigationController? { get }
    func start()
}

extension CoordinatorProtocol {
    var topViewController: UIViewController? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        guard let rootController = keyWindow?.rootViewController else { return nil }
        if let topPresentedViewController = rootController.presentedViewController {
            return topPresentedViewController
        }
        return rootController
    }
}
