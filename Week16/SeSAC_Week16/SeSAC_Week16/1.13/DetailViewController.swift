//
//  DetailViewController.swift
//  SeSAC_Week16
//
//  Created by 김지현 on 2022/01/13.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모든 뷰에 적용하고 싶을 때 뷰디드로드 에서 써줘도 무관
        if let presentationViewController = self.presentationController as? UISheetPresentationController {
            
            // detents? 높이에 대한 배열
            presentationViewController.detents = [.medium(), .large()]
            // 손잡이처럼 생긴 그랩 생김
            presentationViewController.prefersGrabberVisible = true
        }
        
    }
}
