//
//  BeerScrollView.swift
//  SeSAC_Beer
//
//  Created by 김지현 on 2021/12/22.
//

import UIKit
import SnapKit

class BeerScrollView: UIView { // 스크롤 부분 ui
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function, "스크롤")
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(#function)
        configure()
        setupConstraints()
    }
    
    func configure() {
        self.backgroundColor = .brown
    }
    
    func setupConstraints() {
        
    }
}
