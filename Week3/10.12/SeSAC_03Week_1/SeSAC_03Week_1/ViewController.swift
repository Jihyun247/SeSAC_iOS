//
//  ViewController.swift
//  SeSAC_03Week_1
//
//  Created by 김지현 on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func BoxOfficeButtonClicked(_ sender: UIButton) {
        print(#function)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BoxOfficeTableViewController") as! BoxOfficeTableViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

