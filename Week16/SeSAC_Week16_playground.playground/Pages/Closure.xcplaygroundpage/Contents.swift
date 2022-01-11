//: [Previous](@previous)

import Foundation

func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    
    var runningTotal = 0
    
    func incrementer() -> Int {
        
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10) // incrementByTen -> incrementer
// 처음 큰 함수는 실행하고 끝!
// 근데 작은함수를 리턴하기 때문에, incrementByTen은 작은함수가 되는 것, 이 때 큰 함수는 이미 생명주기가 끝났다!
// 큰함수의 runningTotal과 amount 는 메모리에 더 이상 남아있지 않기 때문에 작은함수에 영향을 미치지 않는 것.
// 하지만 작은함수에서는 그 내에서 runningTotal, amount를 내부적으로 저장하고 있다. (캡쳐)
incrementByTen()
incrementByTen()
incrementByTen()

func firstClosure() {
    
    var number = 0
    print("1: \(number)")
    
    // 구조체임, 값타입임 그럼 복사캡쳐가 되어야 함 -> 근데 클래스 처럼 참조가 되는 형태로 캡쳐가 된다.
    // 클로저는 값을 캡쳐할 때, 무조건 참조타입으로 캡쳐하게 된다. => Reference Caputure
    let closure: () -> Void = { [number] in // 해결1. 복사캡쳐 하겠다는 뜻 (외부와 독립적으로)
        print("closure: \(number)")
    }
    
    number = 100
    closure()
    print("2: \(number)")
}

firstClosure()

class User {
     
    var nickname = "jihyun"
    
    lazy var introduce: () -> String = { [weak self] in// 해결2. 약한 참조로 만들어줌 (순환참조 deinit 문제 안생기도록)
        return self!.nickname
    }
    
    deinit {
        print("User Deinit")
    }
}

var nickname: User? = User()
nickname?.introduce
nickname = nil
