//: [Previous](@previous)

import UIKit

protocol MyDelegate: AnyObject { // 클래스 제약을 걸 땐 예전엔 class 였지만 현재 AnyObject로 표시 중
    func sendData(_ data: String)
}

class Main: MyDelegate {
    
    lazy var detail: Detail = { // lazy -> 필요한 시점에 초기화가 됨
       
        let view = Detail()
        view.delegate = self
        return view
    }()
    
    func sendData(_ data: String) {
        print("\(data)를 전달받았습니다.")
    }
    
    deinit {
        print("Main Deinit")
    }
}

class Detail {
    
    // 프로토콜 살펴보면, 선언 시 애플 문서 내에서도 Delegate는 weak로 선언한다.
    weak var delegate: MyDelegate?
    
    func dismiss() {
        delegate?.sendData("안녕")
    }
    
    deinit {
        print("Detail Deinit")
    }
}

var main: Main? = Main()

main = nil
