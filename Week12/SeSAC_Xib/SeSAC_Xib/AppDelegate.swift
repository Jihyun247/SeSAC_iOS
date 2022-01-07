//
//  AppDelegate.swift
//  SeSAC_Xib
//
//  Created by 김지현 on 2021/12/13.
//

import UIKit
import CoreData
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(#function)
        
        // Firebase 초기화
        FirebaseApp.configure()
        
        // 알림 등록 (권한)
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        // 메시지 대리자 설정
        Messaging.messaging().delegate = self

        // 현재 등록 토큰 가져오기 ( 새 토큰이라면 서버에 저장 )
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print(#function)
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print(#function)
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SeSAC_Xib")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // 메서드 재구성을 사용 중지했다면 APN 토큰을 명시적으로 FCM 등록 토큰에 매핑
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    // 포그라운드 수신 : willPresent
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        
        completionHandler([.list, .banner, .badge, .sound])
        // iOS14부터 .alert -> .list, .banner
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("사용자가 푸시를 클릭했습니다")
        
        // userInfo - key - 1광고 2채팅방 3사용자설정
        print(response.notification.request.content.userInfo)
        //print(response.notification.request.content.body)
        
        let userInfo = response.notification.request.content.userInfo
        
        // SceneDelegate Window 객체 가져오기
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as?
                                        SceneDelegate)?.window?.rootViewController?.topViewController else {return}
        print("rootview : ", rootViewController)
        
        if rootViewController is SnapDetailViewController {
            rootViewController.present(DetailViewController(), animated: true, completion: nil)
        }
        
        if userInfo[AnyHashable("key")] as? Int == 1 {
            print("광고 푸시 입니다")
        } else {
            print("다른 푸시 입니다")
        }
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    
    // 토큰 갱신 모니터링
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

// 최상단 뷰컨트롤러를 판단해주는 UIViewController Extension
extension UIViewController {
    
    var topViewController: UIViewController? { // 헐 대박
        return self.topViewController(currentViewController: self)
    }
    
    // currentViewController: TabBarController
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        
        if let tabBarController = currentViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            
            return self.topViewController(currentViewController: selectedViewController)
            
        } else if let navigationController = currentViewController as? UINavigationController,
                   let visibleViewController = navigationController.visibleViewController {
            
                       return self.topViewController(currentViewController: visibleViewController)
            
        } else if let presentedViewController = currentViewController.presentedViewController {
            
            return self.topViewController(currentViewController: presentedViewController)
            
        } else {
            return currentViewController
        }
    }
}

