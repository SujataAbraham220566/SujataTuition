//
//  SujataTuitionApp.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import SwiftUI
import UIKit
import AVKit

//@available(iOS 17.0, *)
@main
struct SujataTuitionApp: App {
    /*init() {
        var testplayer: AVPlayer
    }*/
    
    //public override required init() {
        //FirebaseApp.configure()
    //}

    //let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var studentController = StudentController()
    @StateObject private var sessionController = SessionController()
    @StateObject private var pwdController = PwdController()
    @StateObject private var videoController = VideoController()
    //@StateObject private var userAuth = UserAuth()
    //@State private var email = ""
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


    //@State var path: String = "one"
    //@available(iOS 17.0, *)
    var body: some Scene{
        //FirebaseApp.configure()
        WindowGroup{
            //FirebaseApp.configure()
            //Circle()
            ContentView(studentController: studentController, sessionController: sessionController, pwdController: pwdController, videoController: videoController)
            //.environment(\.managedObjectContext, itemController.container.viewContext)
                .environmentObject(studentController)
                .environmentObject(sessionController)
                .environmentObject(pwdController)
                .environmentObject(videoController)
                .environmentObject(UserAuth())
        }
        /*.onChange(of: scenePhase){ [self] _ in
            //FireBaseApp.configure()
            studentController.save(context: studentController.container.viewContext)
            sessionController.save(context: sessionController.container.viewContext)
            pwdController.save(context: pwdController.container.viewContext)
        }*/
        
        
        
    }
}

//@available(iOS 17.0, *)
/*class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        /*let settings: UIUserNotificationSettings = UINotificationSettings(types: [.badge, .sound], categories: nil)
         //application.UIregisterNotificationSettings(settings)
         //application.registerForRemoteNotifications()*/
        
        Messaging.messaging().delegate = self
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        //return .noData
        if let messageID = userInfo[gcmMessageIDKey]{
            print("Message ID: \(messageID)")
        }
        return UIBackgroundFetchResult.newData
        
        //return [[.sound]]
    }
}
    func Changes(){
        studentController.save(context: studentController.container.viewContext)
        sessionController.save(context: sessionController.container.viewContext)
        pwdController.save(context: pwdController.container.viewContext)

    }


@available(iOS 17.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
        print(userInfo)
        return [[.alert, .sound]]
        //return UIBackgroundFetchResult.newData

    }
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse)  /*completionHandler: @escaping (UIBackgroundFetchResult) -> Void*/
        async -> UNNotificationPresentationOptions {
        let userInfo = response.notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
        print(userInfo)
        return [[.sound]]
    }
    
    
    func application(application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any] ) async -> UIBackgroundFetchResult {
        //Messaging.messaging().apnsToken = deviceToken
        
        //print(userInfo)
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        return UIBackgroundFetchResult.newData
    }
}

@available(iOS 17.0, *)
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let deviceToken: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: deviceToken
      )
    }
}
*/
