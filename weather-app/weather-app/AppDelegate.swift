//
//  AppDelegate.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit
import Realm
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if DEBUG
        let isUnitTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
        guard !isUnitTesting else {
            return true
        }
        #endif
        configureRealmDatabase()
        return true
    }
    
    private func configureRealmDatabase() {
        let documentDirectory = try? FileManager.default.url(for: .documentDirectory,
                                                             in: .userDomainMask,
                                                             appropriateFor: nil,
                                                             create: false)
        let url = documentDirectory?.appendingPathComponent("weather.realm")
        var config = Realm.Configuration(
            // MARK: - Realm database version to change
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                migration.deleteData(forType: Object.className())
            })
        config.shouldCompactOnLaunch = { totalBytes, usedBytes in
            let twentyMB = 1000 * 1024 * 1024
            return (totalBytes > twentyMB)
        }
        config.fileURL = url
        Realm.Configuration.defaultConfiguration = config
        NSLog("Realm path: \(url?.absoluteString ?? "")")
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

