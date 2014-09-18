//
//  AppDelegate.swift
//  RateMyTalk
//
//  Created by Manuel "StuFF mc" Carrasco Molina on 17/09/14.
//  Copyright (c) 2014 Manuel "StuFF mc" Carrasco Molina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        println("Started...")
        TalkManager().fetchAllTalks { (allTalks) -> Void in
            
            let currentTalk = allTalks.filter{
                NSDate.date().compare(($0 as Talk).begin) == NSComparisonResult.OrderedAscending &&
                NSDate.date().compare(($0 as Talk).end) == NSComparisonResult.OrderedDescending
            }.first
            
            let userDefaults = NSUserDefaults(suiteName: "group.biz.pomcast.RateMyTalk")
            userDefaults.setObject(currentTalk, forKey: "currentTalk")
            userDefaults.synchronize()
            
            for talk in allTalks {
                println("=========================")
                println("Name:" + talk.name)
                println("Speaker:" + (talk as Talk).speaker)
                println((talk as Talk).begin)
                println((talk as Talk).end)
                println("=========================")
            }
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        println("Remote notification")
        println(userInfo)
    }

}

