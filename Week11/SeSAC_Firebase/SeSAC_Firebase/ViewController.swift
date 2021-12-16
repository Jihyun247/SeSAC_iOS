//
//  ViewController.swift
//  SeSAC_Firebase
//
//  Created by 김지현 on 2021/12/06.
//

import UIKit
import Firebase
import FirebaseCrashlytics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Test Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//          AnalyticsParameterItemID: "id-\(title!)",
//          AnalyticsParameterItemName: title!,
//          AnalyticsParameterContentType: "cont",
//        ])
//        
//        // 각 화면에 대한 커스텀 애널리틱스를 통해 뷰를 간소화하는 것이 나을지를 판단하는 척도가 될 수도 있다.
//        Analytics.logEvent("share_image", parameters: [
//          "name": "Jihyun" as NSObject,
//          "full_text": "텍스트" as NSObject,
//        ])
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        let numbers = [0]
        let _ = numbers[1]
    }


}

