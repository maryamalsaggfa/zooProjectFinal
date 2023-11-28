//
//  zooProjectFinalApp.swift
//  zooProjectFinal
//
//  Created by maryam on 11/05/1445 AH.
//

import SwiftUI
import FirebaseCore
import Firebase
@main
struct zooProjectFinalApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
           loginScreen()
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
struct Players {
    var userName: String
    var email: String
    var confirmPassWord:String
    var password:String
    
    // Add other properties as needed
}

