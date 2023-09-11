//
//  Strings+Extension.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation

extension String {
    
    // MARK: - Language Localization
    
    public var localized: String {
        let message = NSLocalizedString(self, comment: "")
        if message != self {
            return message
        }
        guard let path = Bundle.main.path(forResource: "en", ofType: "lproj") else { return self }
        guard let bundle = Bundle(path: path) else { return self }
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
    
}
