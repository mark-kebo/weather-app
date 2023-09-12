//
//  RealmManager.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import Foundation
import Realm
import RealmSwift

protocol RealmManagerProtocol: AnyObject {
    func create<T: Object>(_ object: T)
    func delete<T: Object>(_ object: T)
    func readAllOfType<T: Object>(_ objectType: T.Type) -> [T]?
}

final class RealmManager: RealmManagerProtocol {
    func create<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .all)
            }
        }
        catch (let error) {
            let errorMessage = "Can't write Object to DB: \(error.localizedDescription)"
            NSLog(errorMessage)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
            }
        } catch (let error) {
            let errorMessage = "Can't delete Object in DB: \(error.localizedDescription)"
            NSLog(errorMessage)
        }
    }
    
    func readAllOfType<T: Object>(_ objectType: T.Type) -> [T]? {
        do {
            let realm = try Realm()
            return Array(realm.objects(objectType.self))
        } catch (let error) {
            let errorMessage = "Can't read Objects from DB: \(error.localizedDescription)"
            NSLog(errorMessage)
            return nil
        }
    }
}
