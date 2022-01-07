//
//  BeerBottomView.swift
//  SeSAC_Beer
//
//  Created by 김지현 on 2021/12/22.
//

import UIKit

class BeerBottomView: UIView { //  밑부분 버튼 두개 View ui
    
    var refreshButton = UIButton()
    var shareButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(#function, "바텀")
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
        self.backgroundColor = .lightGray
        
        refreshButton.backgroundColor = .blue
        shareButton.backgroundColor = .yellow
    }
    
    func setupConstraints() {
        addSubview(refreshButton)
        addSubview(shareButton)

        self.snp.makeConstraints { make in
            make.height.equalTo(100)
        }

        refreshButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(refreshButton.snp.height)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(shareButton.snp.leading).offset(16)
            make.centerY.equalTo(self.snp.centerY)
        }

        shareButton.snp.makeConstraints { make in
            make.height.equalTo(refreshButton)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(refreshButton.snp.centerY)
        }
    }
}
