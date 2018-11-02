//
//  AppDelegate.swift
//  CasechekTest
//
//  Created by Jared Wheeler on 11/1/18.
//  Copyright © 2018 Jared Wheeler. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //If this is a first-launch, pull the inspection site data into the CoreData
        //stack.  This is a problematic, non-production architecture, for sure.
        if !UserDefaults.standard.bool(forKey: "firstLaunchComplete") {
            DataModel.sharedInstance.refreshSiteData()
            UserDefaults.standard.set(true, forKey: "firstLaunchComplete")
            UserDefaults.standard.synchronize()
        }
        
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        
        return true
    }


    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            return true
        }
        return false
    }

}

