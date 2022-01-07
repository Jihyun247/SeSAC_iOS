//
//  SignupViewModel.swift
//  SeSAC_URLSession
//
//  Created by 김지현 on 2021/12/22.
//

import Foundation
import UIKit

class SignupViewModel { // 뷰에서 데이터가 바뀔 때 뷰모델에서 업데이트 가능 -> 데이터 바인딩
    // View <-> Model wrapping 해놓은 것이 RXSwift
    var navigationTitle: String = "회원가입"
    var buttonTitle: String = "가입하기"
    
    func didTapButton(completion: @escaping () -> Void) {
        completion()
    }
    
    var text: String = "" {
        didSet {
            
            let count = text.count
            let value = count >= 100 ? "작성할 수 없습니다" : "\(count)/100"
            let color: UIColor = count >= 100 ? .red : .black
            
            listener?(value, color)
        }
    }
    
    var listener: ((String, UIColor) -> Void)?
    
    func bind(listener: @escaping (String, UIColor) -> Void) {
        self.listener = listener
    }
}
