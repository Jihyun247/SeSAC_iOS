//
//  SecondViewController.swift
//  SeSAC_Week7
//
//  Created by 김지현 on 2021/11/10.
//

import UIKit

protocol passDateDelegate {
    func sendTextData(text: String)
}

class SecondViewController: UIViewController {
    
    var textSpace: String = ""
    
    @IBOutlet weak var textView: UITextView!
    
    var buttonActionHandler: (() -> ())?
    
    var delegate: passDateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = textSpace
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        buttonActionHandler?()
        
        guard let presentVC = self.presentingViewController else {return}
        
        self.dismiss(animated: true) {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else {return}
            
            presentVC.present(vc, animated: true, completion: nil)
            
            print("화면이 닫혔습니다.")
        }
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("firstNotification"), object: nil, userInfo: ["myText": textView.text!, "value": 123])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {

        if let text = textView.text {
            delegate?.sendTextData(text: text)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
