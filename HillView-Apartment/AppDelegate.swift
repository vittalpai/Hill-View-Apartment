//
//  AppDelegate.swift
//  Hill View Apartment
//
//  Created by Vittal Pai on 7/10/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var image:UIImage? = nil
    





    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MenuItems.addMenuItems()
//        CloudantAdapter.sharedInstance.getDocument { (data) in
//         //   print(data)
//            
//            let vittal =  NSKeyedArchiver.archivedData(withRootObject: data["payload"])
//            let base64String = vittal.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//            let data = Data(base64Encoded: base64String)
//            let image = UIImage(data: data!)
//         print("dine")
//        }
        return true
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
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        ViewController.registerPushToken(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let notification = userInfo["aps"] as? NSDictionary,
            let alert = notification["alert"] as? NSDictionary,
            let body = alert["body"] as? String {
            showAlert(body)
        }
        ViewController.didReciveNotification(userInfo: userInfo, fetchCompletionHandler: completionHandler)
    }
    
    func showAlert(_ message: String) {
        let alertDialog = UIAlertController(title: "Push Notification", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertDialog.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        
        window!.rootViewController?.present(alertDialog, animated: true, completion: nil)
    }
    
 
//        // Synthesize the text
//        let failure = { (error: Error) in print(error) }
//        let voice = "en-US_LisaVoice"
//        textToSpeech.synthesize(
//            text: "afssadfdasfdasfdsa",
//            accept: .wav,
//            voice: voice,
//            failure: failure)
//        {
//            data in
//            do {
//                self.player = try AVAudioPlayer(data: data)
//                self.player!.play()
//            } catch {
//                print("Failed to create audio player.")
//            }
//        }
//    }




}

