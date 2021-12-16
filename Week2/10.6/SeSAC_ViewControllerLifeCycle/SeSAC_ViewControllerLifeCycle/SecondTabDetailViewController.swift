//
//  SecondTabDetailViewController.swift
//  SeSAC_ViewControllerLifeCycle
//
//  Created by jack on 2021/10/06.
//

import UIKit
import TextFieldEffects

class SecondTabDetailViewController: UIViewController {
    
    
    @IBOutlet var mottoTextField: HoshiTextField!
    @IBOutlet var numberLabel: UILabel!
    
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        // 1. 저장하고자 하는 데이터 가져오기
        let userText = mottoTextField.text ?? "열심히 살자"
        
        // 2. 데이터가 확인되었다면 UserDefaults에 Key를 만들고 Key에 데이터를 저장
        UserDefaults.standard.set(userText, forKey: "userMotto")
        // forKey : 저장되는 공간에 대한 이름
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        // let number = Int.random(in: 1...100)
        let number = UserDefaults.standard.integer(forKey: "number")
        // 출첵2 기존 출첵된 숫자에서 1을 더한 값을 새롭게 number에 저장
        UserDefaults.standard.set(number + 1, forKey: "number")
        // 출첵3 레이블에 보여지고 있는 값 업데이트
        let updateNumber = UserDefaults.standard.integer(forKey: "number")
        numberLabel.text = "\(updateNumber)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3. UserDefaults에 저장되어 있는 값 가져오기
        let userMotto = UserDefaults.standard.string(forKey: "userMotto")
        // 4. 값을 표현하고자 하는 뷰 객체(텍스트필드)에 보여주기
        mottoTextField.text = userMotto
        
        // 출첵1
        let number = UserDefaults.standard.integer(forKey: "number")
        numberLabel.text = "\(number)"

        print(self, #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(self, #function)
    }

}
