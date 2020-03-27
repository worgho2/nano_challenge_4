//
//  AppDelegate.swift
//  nano_challenge_4
//
//  Created by otavio on 04/03/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

//var window: UIWindow?


//func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//
//    print("Scene willConnectTo.")
//
//    // Force convert UIScene type variable to UIWindowScene type variable.
//    let windowScene:UIWindowScene = scene as! UIWindowScene;
//
//    // Create the UIWindow variable use above UIWindowScene variable.
//    self.window = UIWindow(windowScene: windowScene)
//
//    // Set this scene's window's background color.
//    self.window!.backgroundColor = UIColor.red
//
//    // Create a ViewController object and set it as the scene's window's root view controller.
//    self.window!.rootViewController = ListaEventosViewController()
//
//    // Make this scene's window be visible.
//    self.window!.makeKeyAndVisible()
//
//
//    guard let _ = (scene as? UIWindowScene) else { return }
//}

import UIKit
import GameKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

