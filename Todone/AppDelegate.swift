//
//  AppDelegate.swift
//  Todone
//
//  Created by Josh Gressman on 3/1/18.
//  Copyright © 2018 Josh Gressman. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        //locate realmDB
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        //Initialize new realmDB container
      
        
        //Add item to realm DB
        do {
            _ = try Realm()
            
        } catch {
            print("Error installing new Realm \(error)")
        }
        
        
     
        return true
    }

}

