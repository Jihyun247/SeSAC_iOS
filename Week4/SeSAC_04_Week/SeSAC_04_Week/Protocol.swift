//
//  Protocol.swift
//  SeSAC_04_Week
//
//  Created by 김지현 on 2021/10/18.
//

import Foundation
import UIKit

// Protocol : 클래스, 구조체 청사진
// 실질적인 구현은 하지 않는다
// 특정 뷰 객체

// 프로토콜 메서드

// 만약 프로토콜을 클래스에서만 사용하게 제한 (구조체에선 사용 못하게됨) OrderSystem: AnyObject(class였는데 바뀜)
@objc
protocol OrderSystem: AnyObject {
    func recommandEventMenu()
    @objc optional func askStampCard(count: Int) -> String // 안써도 되게 됨 (선택적 구현)
    // init()
    // 초기화 구문 : 구조체가 멤버와이즈 구문이 있더라도 프로토콜에 구현되어 있다면 무조건 구현!
    // 클래스 같은 경우, 부모 클래스에 초기화 구문과 프로토콜의 초기화 구문이 구별, 명시
}

class StarBucksMenu {
    
}

class Smoothie: StarBucksMenu, OrderSystem {
    func recommandEventMenu() {
        print("스무디 이벤트 안내")
    }
    
    func askStampCard(count: Int) -> String {
        return "\(count)잔 적립 완료"
    }
    
    
}

class Coffee: StarBucksMenu, OrderSystem {
    
    let smoothie = Smoothie() // is
    
    func test() {
        smoothie is Coffee
        smoothie is StarBucksMenu
        smoothie is OrderSystem // 상속 받은 프로토콜로 형변환 가능
    }
    
    func recommandEventMenu() {
        print("커피 베이컨 이벤트 안내")
    }
    
    func askStampCard(count: Int) -> String {
        return "\(count * 2)잔 적립 완료"
    }
}

// 프로토콜 프로퍼티 : 타입과 get, set만 명시 ! / 연산 프로퍼티로 쓸지 저장 프로퍼티로 쓸지는 상관 없다 !
// 네비게이션 타이틀 string - 공통적인 부분을 묶어주고 싶다 !
protocol NavigationUIProtocol {
    var titleString: String {get set}
    var mainTintColor: UIColor {get} // get만 사용한 경우, get 필수, set은 선택
}

class JackViewController: UIViewController, NavigationUIProtocol {
    var titleString: String = "나의 일기"
    var mainTintColor: UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleString
        view.backgroundColor = mainTintColor
    }
}

class Jack2ViewController: UIViewController, NavigationUIProtocol {
    var titleString: String {
        get {
            return "나의 일기"
        }
        set {
            title = newValue
        }
    }
    var mainTintColor: UIColor { // get만 사용하면 get{} 생략 가능
        return .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleString = "새로운 일기"
    
    }
}

// 연산 프로퍼티

struct SeSACStudent {
    var totalCount = 50
    var currentStudent = 0
    var studentUpdate: String {
        get {
            return "정원 마감까지 \(totalCount - currentStudent)명 남았습니다."
        }
        set {
            currentStudent += Int(newValue)!
        }
    }
}

var sesac = SeSACStudent()
//sesac.studentUpdate = "10"
