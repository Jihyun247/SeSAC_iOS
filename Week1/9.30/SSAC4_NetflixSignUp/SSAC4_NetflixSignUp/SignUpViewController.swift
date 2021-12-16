//
//  SignUpViewController.swift
//  SSAC4_NetflixSignUp
//
//  Created by 김지현 on 2021/10/03.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    // MARK: Outlet
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwdTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var rmdTextField: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var additionalSwitch: UISwitch!
    
    // MARK: Action
    @IBAction func switchAction(_ sender: UISwitch) {
        if additionalSwitch.isOn {
            nicknameTextField.isHidden = false
            locationTextField.isHidden = false
            rmdTextField.isHidden = false
        } else {
            nicknameTextField.isHidden = true
            locationTextField.isHidden = true
            rmdTextField.isHidden = true
        }
    }
    
    @IBAction func keyboardReturnKeyClicked(_ sender: UITextField) {
        //키보드 내리기
        view.endEditing(true)
    }
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        print("회원가입 정보 확인\nID: ")
    }
    
    
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // placeholder, textColor, keyboardType, isSecureTextEntry, textAlignment, borderStyle, backgroundColor
        
        textFieldUISetting(idTextField, "이메일 주소 또는 전화번호")
        textFieldUISetting(pwdTextField, "비밀번호")
        pwdTextField.isSecureTextEntry = true
        textFieldUISetting(nicknameTextField, "닉네임")
        textFieldUISetting(locationTextField, "위치")
        textFieldUISetting(rmdTextField, "추천 코드 입력")
        
        buttonUISetting(signUpButton)
        
        switchUISetting(additionalSwitch)
    
    }
    
    
    // MARK: UISetting
    func textFieldUISetting(_ textField: UITextField, _ t: String) {
        
        // 정리
        textField.attributedPlaceholder = NSAttributedString(string: t, attributes: [.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .darkGray
    }
    
    func buttonUISetting(_ btn: UIButton, _ t: String = "회원가입") {
        btn.setTitle(t, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
    }
    
    func switchUISetting(_ sw: UISwitch) {
        sw.setOn(true, animated: true)
        sw.onTintColor = .systemPink
        sw.thumbTintColor = .white
    }
    
}
