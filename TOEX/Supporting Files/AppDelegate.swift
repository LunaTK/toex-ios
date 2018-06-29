//
//  AppDelegate.swift
//  TOEX
//
//  Created by TaeGeun Moon on 2018. 6. 29..
//  Copyright © 2018년 TaeGeun Moon. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyAY4LZT7JbFyYUPixl4XuYmu5iudo_CLaw")
        GMSPlacesClient.provideAPIKey("AIzaSyAY4LZT7JbFyYUPixl4XuYmu5iudo_CLaw")
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        KOSession.handleDidBecomeActive()
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }
    

}

