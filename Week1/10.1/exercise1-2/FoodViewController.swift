//
//  FoodViewController.swift
//  exercise1-2
//
//  Created by 김지현 on 2021/10/01.
//  Copyright © 2021 김지현. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonUISetting(cookieButton)
        buttonUISetting(chocoButton, "초콜릿")
        buttonUISetting(donutButton, "도너츠")
        
    }
    
    // 매개변수 기본값
    func buttonUISetting(_ btn: UIButton, _ t: String = "사탕") {
        btn.setTitle(t, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .white
    }
    

    @IBOutlet var foodTextField: UITextField!
    @IBOutlet var cookieButton: UIButton!
    @IBOutlet var chocoButton: UIButton!
    @IBOutlet var donutButton: UIButton!
    
    // Did end on exit
    @IBAction func keyboardReturnKeyClicked(_ sender: UITextField) {
        
        //키보드 내리기
        view.endEditing(true)
    }
    
    @IBAction func foodTagButtonClicked(_ sender: UIButton) {

        foodTextField.text = sender.currentTitle
    }
    
    
}
