//
//  DetailViewController.swift
//  SeSAC_Xib
//
//  Created by 김지현 on 2021/12/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let activateButton: MainActivateButton = { //
        let button = MainActivateButton()
        button.setTitle("다음", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [titleLabel, subTitleLabel, activateButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        } // 와 공통 코드 이렇게 처리함

        view.backgroundColor = .white
        
        setTitleLabelConstraints()
        setSubTitleLabelConstraints()
        setActivateButtonConstraints()
    }
    
    func setActivateButtonConstraints() {
        
        NSLayoutConstraint.activate([
            activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activateButton.widthAnchor.constraint(equalToConstant: 300),
            activateButton.heightAnchor.constraint(equalToConstant: 50),
            activateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setTitleLabelConstraints() {
        titleLabel.text = "관심 있는 회사\n3개를 선택해주세요"
        titleLabel.backgroundColor = .darkGray
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        // Frame based ->실제 구현할 땐 frame 기반으로 레이아웃을 잡지 않는다. (예전방법)
        //titleLabel.frame = CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width - 200, height: 80)
        
        // AutoLayout (Constraint based) -> NSLayoutConstraints
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0).isActive = true
        // isActive default가 no 이기 때문에 항상 isActive true를 붙여주어야 한다.
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80).isActive = true
        // toItem 없이 그 자체의 height 정할 때
    }
    
    func setSubTitleLabelConstraints() {
        subTitleLabel.text = "맞춤 정보를 알려드려요."
        subTitleLabel.backgroundColor = .darkGray
        subTitleLabel.textColor = .lightGray
        subTitleLabel.font = .boldSystemFont(ofSize: 13)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        
        let topConstraints = NSLayoutConstraint(item: subTitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: subTitleLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: subTitleLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: subTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
        
        view.addConstraints([topConstraints,centerX,width,heightConstraint])
    }
    
    

}
