//
//  NotiViewController.swift
//  exercise9
//
//  Created by 김지현 on 2021/10/08.
//

import UIKit

class NotiViewController: UIViewController {
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    let ud = UserDefaults.standard
    
    // authorization
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

                    userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
                        if success {
                            self.sendNotification()
                        }
                    }
    }
    
    // request
    func sendNotification() {
        
        // 어떤 정보를 보낼 지 컨텐츠 구성
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "물 마실 시간이에요!"
        notificationContent.body = "하루 2리터 목표 달성을 위해 열심히 달려보아요"
        notificationContent.badge = 100
        // p 굉장히 많음 !
                
        // 언제 보낼 지 설정 : 1. 간격, 2. 캘린더, 3. 위치
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        // 알림 요청 (identifier:고유한 식별자(알림마다 이름이 있음, 이름이 같으면 교체가 됨, 따라서 날짜로 식별자를 설정하면 알림이 쌓이게 됨), content, trigger)
        let request = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: trigger)

        //
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        requestNotificationAuthorization()
        // Do any additional setup after loading the view.
    }

}
