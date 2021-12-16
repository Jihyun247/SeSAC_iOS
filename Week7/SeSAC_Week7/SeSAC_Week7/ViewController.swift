//
//  ViewController.swift
//  SeSAC_Week7
//
//  Created by 김지현 on 2021/11/10.
//

import UIKit

class ViewController: UIViewController, passDateDelegate {
    
    func sendTextData(text: String) {
        textView.text = text
    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(notification:)), name: NSNotification.Name("firstNotification"), object: nil)    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("firstNotification"), object: nil)
    }
    
    @objc func firstNotification(notification: NSNotification) {
        if let text = notification.userInfo?["myText"] as? String {
            textView.text = text
        }
        print("NOTIFICATION!")
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
        
        vc.buttonActionHandler = {
            self.textView.text = vc.textView.text
        }
        vc.textSpace = textView.text
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
        
        // 잊지말자 delegate
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}

// 다른 파일에 한번에 정리
extension Notification.Name {
    static let myNotification = NSNotification.Name("firstNotification")
}

