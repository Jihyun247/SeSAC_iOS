//
//  ProfileViewController.swift
//  SeSAC_WaterApp
//
//  Created by 김지현 on 2021/10/08.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController {
    
    // MARK: 변수
    var nickname: String = "이름"
    var height: Int = 0
    var weight: Int = 0
    
    // MARK: IBOutlet
    @IBOutlet var setNicknameLabel: UILabel!
    @IBOutlet var setHeightLabel: UILabel!
    @IBOutlet var setWeightLabel: UILabel!
    @IBOutlet var nicknameTextField: HoshiTextField!
    @IBOutlet var heightTextField: HoshiTextField!
    @IBOutlet var weightTextField: HoshiTextField!
    
    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickname = UserDefaults.standard.string(forKey: "nickname") ?? "이름"
        height = UserDefaults.standard.integer(forKey: "height")
        weight = UserDefaults.standard.integer(forKey: "weight")
        
        viewSetting()
        navigationBarSetting()
        labelSetting(setNicknameLabel, "닉네임을 설정해주세요", 15)
        labelSetting(setHeightLabel, "키(cm)를 설정해주세요", 15)
        labelSetting(setWeightLabel, "몸무게(kg)를 설정해주세요", 15)
        textFieldSetting(nicknameTextField, nickname)
        textFieldSetting(heightTextField, String(height))
        textFieldSetting(weightTextField, String(weight))
        
        
        print("profileVC viewdidload")
    }

    // MARK: function
    
    func viewSetting() {
        view.backgroundColor = .myGreenColor
    }
    
    func navigationBarSetting() {
        navigationController?.navigationBar.tintColor = .white
    }
    
    func labelSetting(_ label: UILabel, _ text: String, _ textSize: Int) {
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: CGFloat(textSize))
        label.numberOfLines = 0
    }
    
    // make sure your built products contains either an application or a framework product 에러,, 머가 문제지 ? !
    func textFieldSetting(_ tfield: HoshiTextField, _ txt: String) {
        tfield.text = txt
        tfield.textColor = .white
        tfield.textAlignment = .left
        tfield.font = UIFont.systemFont(ofSize: 17)
        tfield.backgroundColor = .clear
        tfield.keyboardType = .default
        tfield.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    // MARK: IBAction
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        let newNickname = nicknameTextField.text ?? ""
        let newHeight = heightTextField.text ?? ""
        let newWeight = weightTextField.text ?? ""
        
        if newNickname == "" || newHeight == "0" || newWeight == "0" || newHeight == "" || newWeight == "" {
            let alert = UIAlertController(title: "알림", message: "프로필 내용을 모두 채워주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        } else {
            UserDefaults.standard.set(newNickname, forKey: "nickname")
            UserDefaults.standard.set(Int(newHeight)!, forKey: "height")
            UserDefaults.standard.set(Int(newWeight)!, forKey: "weight")
        }
    
        let alert = UIAlertController(title: "알림", message: "저장되었습니다 :)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    

}
