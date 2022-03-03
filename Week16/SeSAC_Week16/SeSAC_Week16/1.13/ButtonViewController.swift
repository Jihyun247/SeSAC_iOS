//
//  ButtonViewController.swift
//  SeSAC_Week16
//
//  Created by 김지현 on 2022/01/13.
//

import UIKit
import SnapKit

//print("Hello") // 출력 당연히 안됨 함수, 클래스와 같이 쌓여있지 않은 것을 Top - level 이라고 함

class ButtonViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
            button.center = view.center
            button.configurationUpdateHandler = { btn in
    //            if btn.isHighlighted {
    //                btn.backgroundColor = .black
    //            }
            }
            button.configuration = .jhStyle()
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            view.addSubview(button)
        }
    }
    
    func deferExample() -> String {
        
        var nickname = "고래밥"
        
        defer { // scope 끝에 실행됨. 함수 리소스 정리할 떄 많이 사용됨. 함수 실행 끝나고 리턴까지 되었을 때 실행됨
            nickname = "미묘한도사"
            print("defer")
        }
        
        return nickname
    }
    
    func deferExample2() -> String? {
        
        var nickname: String? = "고래밥"
        
        defer { // scope 끝에 실행됨. 함수 리소스 정리할 떄 많이 사용됨. 함수 실행 끝나고 리턴까지 되었을 때 실행됨 보통 NSLock 쓸 때 Defer 씀 (deadlock 해결할 수 있는 방법)
            nickname = nil
        }
        
        return nickname
    }
    
    func deferExample3() {
        
        // stack처럼 마지막에 써준 것이 먼저 출력된다
        // 중첩은 바깥부터 안쪽으로 출력
        
        defer {
            print("example1")
        }
        defer {
            print("example2")
        }
        defer {
            print("example3")
        }
        defer {
            print("example4")
        }
    }
    
    func dateFormatStyle() {
        
        let value = Date()
        
        print(value)
        print(value.formatted())
        print(value.formatted(date: .complete, time: .shortened))
        print(value.formatted(date: .omitted, time: .shortened))
        
        let locale = Locale(identifier: "KO-KR")
        
        let result = value.formatted(.dateTime.locale(locale).day().month(.twoDigits).year())
        print(result)
        let result2 = value.formatted(.dateTime.day().month(.twoDigits).year())
        print(result2)
    }
    
    func numberFormatStyle() {
        // 퍼센트
        print(50.formatted(.percent))
        // 콤마
        print(1234565634.formatted())
        // 환율
        print(435454354.formatted(.currency(code: "eur")))
        
        let result = ["올라프", "미키마우스", "뽀로로"].formatted()
        print(result)
    }
    
    @objc func buttonClicked() {
        
        //let vc = DetailViewController()

        self.navigationController?.pushViewController(ChatViewController(), animated: true)
        //self.present(vc, animated: true, completion: nil)
    }
    
    // Color picker
    @objc func buttonClicked2() {
        
        let picker = UIColorPickerViewController()
        picker.delegate = self
        if let presentationController = picker.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            presentationController.prefersGrabberVisible = true
        }
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        if let presentationController = viewController.presentationController as? UISheetPresentationController {
            presentationController.selectedDetentIdentifier = .medium
        }
        
        view.backgroundColor = color
    }
}


@available (iOS 15.0, *)
extension UIButton.Configuration {
    
    static func jhStyle() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "SESAC"
        configuration.subtitle = "로그인 없이 둘러보기"
        configuration.titleAlignment = .trailing
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .red
        configuration.image = UIImage(systemName: "star.fill")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 50
        configuration.cornerStyle = .capsule
        //configuration.showsActivityIndicator = true // 이미지 자리에서 뱅글뱅글 돌아감
        return configuration
    }
}
