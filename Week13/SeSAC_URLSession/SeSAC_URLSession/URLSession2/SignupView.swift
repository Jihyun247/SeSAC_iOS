//
//  SignupView.swift
//  SeSAC_URLSession
//
//  Created by 김지현 on 2021/12/22.
//

import UIKit
import SnapKit

class SignupView: UIView {
    
    // SignupViewController UI
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signupButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        setupConstraints()
    }
    
    func configure() {
        emailTextField.backgroundColor = .yellow
        passwordTextField.backgroundColor = .yellow
        signupButton.backgroundColor = .blue
    }
    
    func setupConstraints() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(signupButton)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalTo(emailTextField)
            make.trailing.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalTo(passwordTextField)
            make.trailing.equalTo(passwordTextField)
            make.height.equalTo(passwordTextField)
        }
    }
}
