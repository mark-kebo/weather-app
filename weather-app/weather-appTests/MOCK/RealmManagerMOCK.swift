//
//  RealmManagerMOCK.swift
//  weather-appTests
//
//  Created by Dima Worożbicki on 12/09/2023.
//

import Foundation
@testable import weather_app

class RealmManagerMOCK: RealmManagerProtocol {
    private var entities: [AnyHashable] = []
    
    func create<T: Hashable>(_ object: T) {
        entities.append(object)
    }
    
    func delete<T: Hashable>(_ object: T) {
        guard let index = entities.firstIndex(of: object as AnyHashable) else { return }
        entities.remove(at: index)
    }
    
    func readAllOfType<T: Hashable>(_ objectType: T.Type) -> [T]? {
        entities.filter({ $0 is T }) as? [T]
    }
}
