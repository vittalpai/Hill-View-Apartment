//
//  BMSPush.swift
//  Hill View Apartment
//
//  Created by Vittal Pai on 7/10/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import Foundation
import UIKit
import BMSCore
import BMSPush


 // Add IBM Cloud Push notification service credentials
let myBMSClient = BMSClient.sharedInstance
let push =  BMSPushClient.sharedInstance
let cloudRegion = BMSClient.Region.usSouth
let pushAppGUID = "64bc3b3b-cfce-4b1b-85bf-f9ac2d431b75"
let pushClientSecret = "27843a9f-eb49-46c7-8320-1420411950a3"
let userId = "asdas"
let customeDeviceId = "asdas"
let pushVariables = ["username":"asd","accountNumber":"asdsa"]

var tagsArray:[String] = []

extension ViewController : BMSPushObserver {
    func onChangePermission(status: Bool) {
        
    }
    
    func registerBMSPush()  {
        
        // Initialize BMSCore SDK
        myBMSClient.initialize(bluemixRegion: cloudRegion)
        //Initialize BMSPush SDK
        
        let notifOptions = BMSPushClientOptions()
        notifOptions.setDeviceId(deviceId: customeDeviceId)
        
        notifOptions.setPushVariables(pushVariables: pushVariables)
        push.initializeWithAppGUID(appGUID: pushAppGUID, clientSecret: pushClientSecret , options: notifOptions)
    }
    
    static func registerPushToken(deviceToken: Data) {
        if userId.isEmpty  {
            push.registerWithDeviceToken(deviceToken: deviceToken) { (response, status, error) in                    if error.isEmpty {
                print("BMSPush: Register Success!\n message: " + response!)
                    } else {
                        print("BMSPush: Register Error!\n message: " + error)
                    }
            }
        } else {
            push.registerWithDeviceToken(deviceToken: deviceToken, WithUserId: userId) { (response, status, error) in
                    if error.isEmpty {
                        print("BMSPush: Register Success!\n message: " + response!)
                    } else {
                        print("BMSPush: Register Error!\n message: " + error)
                    }
            }
            
        }
    }
    
    static func didReciveNotification(userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let notification = userInfo["aps"] as? NSDictionary,
            let alert = notification["alert"] as? NSDictionary,
            let body = alert["body"] as? String {
            if let topVC: ViewController = UIApplication.getTopMostViewController() as! ViewController {
                topVC.playAudio(message: body)
            }
        }
        
      

        push.didReciveBMSPushNotification(userInfo: userInfo) { (response, error) in
            
            DispatchQueue.main.async(execute: {})
            completionHandler(.noData)
        }
        
    }
    
    static func vittal() {
        if let topVC:ViewController = UIApplication.getTopMostViewController() as! ViewController {
            topVC.playAudio(message: "asdfdsafds")
        }
    }
    
    
    private func callAlert(title:String, message:String){
        print("BMSPush:" + title + "\n message: " + message)
    }
    
    
}


