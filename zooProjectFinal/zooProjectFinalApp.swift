//
//  zooProjectFinalApp.swift
//  zooProjectFinal
//
//  Created by maryam on 11/05/1445 AH.
//

import SwiftUI
import FirebaseCore
import Firebase
import CoreLocation
@main
struct zooProjectFinalApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let locationManager = CLLocationManager()

    var body: some Scene {
        WindowGroup {
           SplashScreen()
                .onAppear {
                    AudioPlayer.shared.playMusic()
                }
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
    var latitude:String
    var longitude:String
    // Add other properties as needed
}
struct invations: Identifiable {
    var id: UUID { invationKey } // Use invationKey as the id
    var invationKey: UUID
    var senderLionKey: String
    var isAccepted: String
    var accepterCatID: String
}

struct currentUserNow{
    var userNmae:String
    var password:String
}

