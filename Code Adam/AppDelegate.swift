//
//  AppDelegate.swift
//  Code Adam
//
//  Created by 刘祥 on 3/22/19.
//  Copyright © 2019 xiangliu90. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        InstanceID.instanceID().instanceID(handler: { (result, error) in
            if error != nil{
                print("there is an error \(error!)")
            }
            if let result = result{
                print("the token is \(result.token)")
            }
     
        })
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let info = extractUserInfo(userInfo: userInfo)
        print("+++++++++++++++++++++++++")
        print(info.title)
        print(info.body)
        guard let hat = userInfo["hat"] as? String else {return}
        guard let hatcolor = userInfo["hatcolor"] as? String else {return}
        guard let age = userInfo["age"] as? String else {return}
        guard let gender = userInfo["gender"] as? String else {return}
        guard let shoes = userInfo["shoes"] as? String else {return}
        guard let shoescolor = userInfo["shoescolor"] as? String else {return}
        guard let up = userInfo["up"] as? String else {return}
        guard let upcolor = userInfo["upcolor"] as? String else {return}
        guard let low = userInfo["low"] as? String else {return}
        guard let lowcolor = userInfo["lowcolor"] as? String else {return}

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "trackViewController") as! TrackViewController
        controller.body = up
        controller.bodyColor = upcolor
        controller.head = hat
        controller.headColor = hatcolor
        controller.age = age
        controller.leg = low
        controller.legColor = lowcolor
        controller.shoes = shoes
        controller.shoesColor = shoescolor
        controller.gender = gender
        let root = UIApplication.shared.keyWindow!.rootViewController as! ViewController
        root.present(controller, animated: true, completion: nil)
    }
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("this is in app mess")
//    }
    
    
    func extractUserInfo(userInfo: [AnyHashable : Any]) -> (title: String, body: String) {
        var info = (title: "", body: "")
        guard let aps = userInfo["aps"] as? [String: Any] else { return info }
        guard let alert = aps["alert"] as? [String: Any] else { return info }
        let title = alert["title"] as? String ?? ""
        let body = alert["body"] as? String ?? ""
        info = (title: title, body: body)
        return info
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

