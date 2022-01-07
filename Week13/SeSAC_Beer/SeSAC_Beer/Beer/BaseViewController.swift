//
//  BaseViewController.swift
//  SeSAC_Beer
//
//  Created by 김지현 on 2021/12/22.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController { // 공통 부분 끝 !
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupConstraints()
        
    }
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        
    }
    
}
