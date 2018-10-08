//
//  AppDelegate.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/2/18.
//

import UIKit
import DataManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Set up Core Data
        DataManager.setUp(withDataModelName: "FlickrFinderCoreData", bundle: .main, persistentStoreName: "FlickrFinderCoreData")
        return true
    }
}

