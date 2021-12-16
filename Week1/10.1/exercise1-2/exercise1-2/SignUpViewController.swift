//
//  SignUpViewController.swift
//  exercise1-2
//
//  Created by 김지현 on 2021/09/30.
//  Copyright © 2021 김지현. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
    
        view.endEditing(true)
        
    }
    
}
