//
//  ViewController.swift
//  Layout
//
//  Created by 김지현 on 2021/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    
    var heightStatus = true
    
    /*
     Button Device 수평 수직 중앙
     button, label 등 컨텐츠 크기에 영향을 받음
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func blackButtonClicked(_ sender: UIButton) {
        
        print("버튼누름")
        
        heightStatus = !heightStatus
        
        self.containerViewHeight.constant = self.heightStatus ? 50 : UIScreen.main.bounds.height * 0.2
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    


}

