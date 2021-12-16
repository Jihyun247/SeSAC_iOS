//
//  SquareBoxView.swift
//  SeSAC_Xib
//
//  Created by 김지현 on 2021/12/13.
//

import Foundation
import UIKit

class SquareBoxView: TapAnimationView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    // required 가 붙는 이유 = NSCoder 프로토콜의 초기화 구문 -> 프로토콜 프로토콜에서 온거야 라고 명시하기 위해 required라고 붙는다.
    // NSCoder? ->
    // 1. 정상적으로 빌드를 하려면 컴파일(번역) 과정이 필요하다. 컴파일 성공을 하면 여러 깃헙 파일이 생성되어 빌드가 된다. 스위프트 파일 말고도 스토리보드 파일도 있고, asset, XIB 등 여러 파일이 많을 것이다.
    // 2. XIB는 XML Interface Builder의 약자인데, 컴파일의 입장에선 번역할 수 없습니다. 그래서 XIB는 nib 파일로 내부적으로 변경한 다음 컴파일을 할 수 있도록 만듭니다.
    // 3. 변환한 nib를 통해 재조립하여 컴파일하고 해체하는 것을 unarchiving, deserialize/serialize
    // 4. 이런 과정을 도와주는 것이 바로 NSCoder 프로토콜이다.
    // 5. Codable, Decodable 또한 외부의 코드를 컴파일 할 수 있도록 하는 프로토콜들
    
    // 오버라이드 작성 가능 - xib 기반으로 만들어져있기 떄문에 굳이 오버라이드 사용하지 않아도 됨
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadView()
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadView()
        loadUI()
    }
    
    func loadView() {
        
        //bundle에 대해 nil를 사용하면 디폴트(main bundle)가 사용된다는 말
        // 닙파일 만들자 ! 인스턴스화 시킴
        let view = UINib(nibName: "SquareBoxView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        self.addSubview(view)
    }
    
    func loadUI() {
        label.font = .boldSystemFont(ofSize: 13)
        label.text = "마이페이지"
        label.textAlignment = .center
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
    }
}

class TapAnimationView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 누를 때 애니메이션
        print(#function)
        
        DispatchQueue.main.async {
            self.alpha = 1.0
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
                self.alpha = 0.6
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 뗄 때 애니메이션
        print(#function)
        
        DispatchQueue.main.async {
            self.alpha = 0.6
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 얼럿
        print(#function)
        
        DispatchQueue.main.async {
            self.alpha = 0.6
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
                self.alpha = 1.0
            }
        }
    }
}
