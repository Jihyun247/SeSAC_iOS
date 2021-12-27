//
//  SignInView.swift
//  SeSAC_Week14
//
//  Created by 김지현 on 2021/12/27.
//

import UIKit
import SnapKit

protocol ViewPresentable {
    func setupView()
    func setupConstraints()
}

class SignInView: UIView, ViewPresentable {
    
    let usernameTextField = UITextField()
    let passwordTexrField = UITextField()
    let signInButton = UIButton()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { // XIB 안만들어서 여기선 이번엔 호출 안해줘도 됨
        super.init(coder: coder)
        
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        addSubview(usernameTextField)
        addSubview(passwordTexrField)
        addSubview(signInButton)
        
        usernameTextField.backgroundColor = .blue
        passwordTexrField.backgroundColor = .blue
        signInButton.backgroundColor = .orange
    }
    
    func setupConstraints() {
        
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9) // 여기서 self - signinView
            make.height.equalTo(50)
        }
        
        passwordTexrField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9) // 여기서 self - signinView
            make.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTexrField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9) // 여기서 self - signinView
            make.height.equalTo(50)
        }
    }
    
}
