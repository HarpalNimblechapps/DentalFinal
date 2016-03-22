//
//  AppDelegate.swift
//  Dental
//
//  Created by Nimble Chapps on 21/03/16.
//  Copyright © 2016 Nimble Chapps. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Twitter.sharedInstance().startWithConsumerKey("r6sxnnGdEFd7NxYCPBtyvYblR", consumerSecret: "fzfQOgJZPfhfIC0he1XCAVtrVEIzFVKxGuCy1s73sfsp9Q7zeD")
        Fabric.with([Twitter.sharedInstance()])
        
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
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
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
}

