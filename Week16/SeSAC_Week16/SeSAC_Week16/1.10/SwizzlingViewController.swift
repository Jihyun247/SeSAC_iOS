//
//  SwizzlingViewController.swift
//  SeSAC_Week16
//
//  Created by 김지현 on 2022/01/10.
//

import Foundation
import UIKit

class SwizzlingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }
}

extension UIViewController {
    
    // 메서드 -> 런타임 실행 메서드
    // #selector : 런타임 @objc (swift4 ~)
    class func swizzleMethod() {
        
        let origin = #selector(viewWillAppear)
        let change = #selector(changeViewWillAppear)
        
        guard let oMethod = class_getInstanceMethod(UIViewController.self, origin), let cMethod = class_getInstanceMethod(UIViewController.self, change) else {
            print("함수를 찾을 수 없거나 오류")
            return
        }
        
        method_exchangeImplementations(oMethod, cMethod)
    }
    
    @objc func changeViewWillAppear() {
        print("changeViewWillAppear")
    }
}
