import Foundation
import UIKit


// ----- extension을 통한 init
class User {
    var name: String = ""
    var age: Int = 0
}

struct UserStruct {
    var name: String = ""
    var age: Int = 0
}

// extension 으로 init을 정의하면, 더 많은 형태의 초기화를 실행할 수 있다.
extension UserStruct {
    init(age: Int) {
        self.name = "손님"
        self.age = age
    }
}

// 인스턴스 - 저장 프로퍼티 포기화
let a = User() // 초기화 구문, 초기화 메서드 -> Default Initailizer
let b = UserStruct(name: "", age: 9) // -> Memberwise Initializer
let c = UserStruct()
let d = UserStruct(age: 21)


// ----- UIColor의 init
// 둘 다 같은 의미 !
let color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
let color2 = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)

// ----- 편의 생성자, convenience initializer
// 모든 프로퍼티에 대해 초기화 되어 있는 initializer를 designated initializer 라 부름
// convenience initializer 내에는 designated initailizer를 통해 특정 프로퍼티 외의 모든 프로퍼티를 한번에 정의
class Coffee {
    let shot : Int
    let size : String
    let menu : String
    let mind : String
    
    init(shot: Int, size: String, menu: String, mind: String) {
        self.shot = shot
        self.size = size
        self.menu = menu
        self.mind = mind
    }
    
    convenience init(value: String) {
        self.init(shot: 2, size: "보통", menu: value, mind: "대략정성")
    }
}

let coffee = Coffee(shot: 2, size: "크게", menu: "아아", mind: "정성듬뿍")
let coffee2 = Coffee(value: "뜨아")


extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let customColor = UIColor(red: 28, green: 12, blue: 205)

// 2. 프로토콜 초기화 구문
// 프로토콜 - 프로퍼티, 메서드, 초기화 구문
protocol Jhyun {
    init() // 무조건 초기화 구문을 적어라
}

//class Hello {
//
//    init() {
//
//    }
//}
//-----------------------------------------------------------------
//class Hello: Jhyun {
//
//    required init() { // 프로토콜에 명시되어있다는걸 알려주는 required
//
//    }
//}
//
//class HelloBrother: Hello {
//    required init() {
//
//    }
//}
//-----------------------------------------------------------------
class Hello {

    init() { // 프로토콜에 명시되어있다는걸 알려주는 required
        print("Hello")
    }
}


// required는 프로토콜로부터, override는 부모클래스로부터
class HelloBrother: Hello, Jhyun {
    required override init() {
        super.init() //
        
        print("HelloBrother")
    }
}

let hello = HelloBrother()


// 3. 초기화구문 델리게이션
class A {
    var value: Int
    
    init() {
        self.value = 10
    }
}

class B: A {
    override init() {
        super.init()
        print("B")
    }
}

class C: B {
    override init() {
        super.init()
        print("C")
    }
    
    deinit {
        print("deinit")
    }
}

var test: C? = C()
test = nil
