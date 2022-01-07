//
//  SignupViewController.swift
//  SeSAC_URLSession
//
//  Created by 김지현 on 2021/12/22.
//

import UIKit

class SignupViewController: BaseViewController { // 로직 담당
    
    var mainView = SignupView() // 뷰 ui 담당
    var viewModel = SignupViewModel() // 뷰 모델 데이터 담당
    
    // loadView 다음에 viewDidLoad가 호출됨 (뷰컨의 루트뷰를 로드할 때 호출되는 메서드)
    // 새로운 뷰를 반환하려고 할 때 사용 !
    override func loadView() {
        self.view = mainView // 이 뷰컨의 뷰를 메인뷰로 !
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind { text, color in
            self.mainView.passwordTextField.text = text
            self.mainView.passwordTextField.textColor = color
        }
        
    }
    
    override func configure() {
        title = viewModel.navigationTitle
        mainView.emailTextField.placeholder = "이메일을 작성해주세요"
        mainView.emailTextField.text = viewModel.text
        mainView.signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        mainView.signupButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    override func setupConstraints() {
        
    }
    
    @objc func signupButtonClicked() {
        print(#function)
        
        guard let text = mainView.emailTextField.text else {return}
        viewModel.text = text
    }
}
