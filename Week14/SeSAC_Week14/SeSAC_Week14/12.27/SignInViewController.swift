//
//  ViewController.swift
//  SeSAC_Week14
//
//  Created by 김지현 on 2021/12/27.
//

import UIKit

class SignInViewController: UIViewController {
    
    let mainView = SignInView()
    var viewModel = SignInViewModel()
    
    override func loadView() {
        super.loadView()
        
        self.view = mainView
        // 먼저 signinView 를 인스턴스로 초기화 시켜놔야 해당 뷰 안의 것들 접근 가능!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.username.bind { text in
            self.mainView.usernameTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.mainView.passwordTexrField.text = text
        }
        
        mainView.signInButton.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.signInButton.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        
        // 뷰에 정보를 띄우는 역할은 뷰모델이기 때문에 뷰컨에서 바로 nickname을 가져오기 보단 뷰모델에서 함수를 선언한 다음 가져오는 것이 더 구조적이다
        viewModel.getUserName()
    }
    
    @objc func usernameTextFieldDidChange(_ textField: UITextField) {
        viewModel.username.value = textField.text ?? ""
    }
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func signInButtonClicked() {
        viewModel.postUserLogin {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }


}

