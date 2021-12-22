//
//  SignupViewController.swift
//  SeSAC_URLSession
//
//  Created by 김지현 on 2021/12/22.
//

import UIKit

class SignupViewController: BaseViewController {
    
    var mainView = SignupView()
    
    // loadView 다음에 viewDidLoad가 호출됨 (뷰컨의 루트뷰를 로드할 때 호출되는 메서드)
    // 새로운 뷰를 반환하려고 할 때 사용 !
    override func loadView() {
        self.view = mainView // 이 뷰컨의 뷰를 메인뷰로 !
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        mainView.emailTextField.placeholder = "이메일을 작성해주세요"
        mainView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
    }
    
    override func setupConstraints() {
        
    }
    
    @objc func signupButtonClicked() {
        print(#function)
    }
}
