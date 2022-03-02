//
//  LoginViewController.swift
//  Week23_Test
//
//  Created by 김지현 on 2022/03/02.
//

import Foundation
import UIKit


//id. @ 6자리 이상
//pw. 6자리 이상 10자리 미만
//check. pw와 같은지
class LoginViewController: UIViewController {
    
    var user = User(email: "", password: "", check: "")
    var validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var checkTextField: UITextField!
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        if validator.isValidID(id: idTextField.text!) && validator.isValidPassword(password: pwdTextField.text!) && validator.isEqualPassword(password: pwdTextField.text!, check: checkTextField.text!) {
            print("성공")
        } else {
            print("실패")
        }
    }
}
