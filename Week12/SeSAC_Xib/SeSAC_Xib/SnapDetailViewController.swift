//
//  SnapDetailViewController.swift
//  SeSAC_Xib
//
//  Created by 김지현 on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {
    
    let activateButton: MainActivateButton = {
        let button = MainActivateButton()
        button.setTitle("클릭", for: .normal)
        button.addTarget(self, action: #selector(activateButtonPushClicked), for: .touchUpInside)
        return button
    }()
    
    // 코드로 커스텀 클래스를 사용할 경우, override init 이 필요! 만약 스토리보드에 직접 설정해준 경우는 Required init 필요
    // 그래서 둘 다 해주는게 좋음
    let firstSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "trash.fill")
        return view
    }()
    
    let secondSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스증권"
        view.imageView.image = UIImage(systemName: "chart.xyaxis.line")
        return view
    }()
    
    let thirdSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "고객센터"
        view.imageView.image = UIImage(systemName: "person")
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "13,532원"
        return label
    }()
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    @objc func activateButtonClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        vc.name = "고래밥"
//        let vc = DetailViewController()
        present(vc, animated: true, completion: nil)
    }
    
    @objc func activateButtonPushClicked() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // StackView
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstSquareView)
        stackView.addArrangedSubview(secondSquareView)
        stackView.addArrangedSubview(thirdSquareView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view.snp.width).multipliedBy(0.8/1.0)
            $0.height.equalTo(80)
        }
        
        view.backgroundColor = .white
        [activateButton, moneyLabel, descriptionLabel, redView].forEach {
            view.addSubview($0)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
        
        activateButton.snp.makeConstraints {
            $0.leadingMargin.equalTo(view)
            $0.trailingMargin.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view).multipliedBy(0.1)
        }
        
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
            
            // 화면 꽉 채우고 싶다고 할 때 이렇게 네 줄로 표현할 수도 있지만
//            make.top.equalTo(view)
//            make.leading.equalTo(view)
//            make.trailing.equalTo(view)
//            make.bottom.equalTo(view)
            
            // 한번에 설정하는 방법
            //make.edges.equalToSuperview().inset(100).offset(50) // 사방 일괄 여백, offset은 x 값 +
            
            make.bottom.equalTo(-500)
        }
        
        redView.addSubview(blueView)
        blueView.backgroundColor = .blue
        
        blueView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(50)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstSquareView.alpha = 0
        secondSquareView.alpha = 0
        thirdSquareView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.firstSquareView.alpha = 1
        } completion: { bool in
            
            UIView.animate(withDuration: 1) {
                self.secondSquareView.alpha = 1
            } completion: { bool in
                
                UIView.animate(withDuration: 1) {
                    self.thirdSquareView.alpha = 1
                }
            }

        }

    }
}
