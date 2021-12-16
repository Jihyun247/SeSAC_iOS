//
//  RandomViewController.swift
//  exercise1-2
//
//  Created by 김지현 on 2021/09/29.
//  Copyright © 2021 김지현. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {
    
    @IBOutlet var rLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    
    // 뷰컨트롤러 생명주기
    // 화면이 사용자에게 보이기 직전에 실행되는 기능 viewDidLoad : 모서리 둥글게, 그림자 속성 등 스토리보드에서 구현하기 까다로운 UI를 미리 구현할 때 주로 사용
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rLabel.text = "안녕하세요"
        rLabel.textAlignment = .center
        rLabel.backgroundColor = .systemRed
        rLabel.numberOfLines = 2
        rLabel.font = UIFont.boldSystemFont(ofSize: 20)
        rLabel.textColor = UIColor.white
        rLabel.layer.cornerRadius = 10
        // clipstoBounds -> 모서리 수정할 수 있도록 true로 설정해야 radius가 적용됨
        rLabel.clipsToBounds = true
        
        checkButton.backgroundColor = UIColor.magenta
        // normal은 아무 행동 없을 때, highlighted는 버튼이 눌렸을 때
        checkButton.setTitle("행운의 숫자를 뽑아보세요", for: .normal)
        checkButton.setTitle("뽑아 뽑아", for: .highlighted)
        checkButton.layer.cornerRadius = 10
        checkButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        let number = Int.random(in: 1...100)
        rLabel.text = "행운의 숫자는 \(number)입니다."
    }
    
    

}
