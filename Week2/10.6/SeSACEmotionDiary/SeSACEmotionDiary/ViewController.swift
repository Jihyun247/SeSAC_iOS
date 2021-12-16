//
//  ViewController.swift
//  SeSACEmotionDiary
//
//  Created by 김지현 on 2021/10/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIColor
        // 1. 테투리 색상
        // 레이블.layer.borderColor = .init 혹은 UIColor.red.cgColor (cgcolor로 변환)
        // bordercolor 은 cgcolor 이기 때문에 uicolor로 설정하면 오류 남
        
        // 2. 커스텀 컬러 (HEX코드 보단 RGB로)
        // 레이블.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.9)
        // UIColor(named: "contentBackground") name을 통해서도 custom color 이용 가능
    }


}

