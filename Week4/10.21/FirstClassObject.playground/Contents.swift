import UIKit
import Foundation

/*
 1. 1급 객체
 - 변수나 상수에 함수를 대입할 수 있다.
 
 */

// 변수나 상수에 함수를 대입할 수 있다.
func checkBackInformation(bank: String) -> Bool {
    // 계좌가 있는지 없는지
    let bankArray = ["우리", "KB", "신한"]
    return bankArray.contains(bank) ? true:false
}

// 변수나 상수에 함수를 실행하고 나온 반환값을 대입
let jack = checkBackInformation(bank: "우리")

// 함수 자체를 대입
let jackAccount = checkBackInformation
jackAccount("신한")

// (String) -> Bool 이게 뭘까? = Function Type 타입어노테이션

let tupleExample: (Int, Bool, String, Double) = (1, true, "dkd", 3.3)
tupleExample.1

// Function Type 1. (String) -> String
func hello(nickname: String) -> String {
    return "저는 \(nickname)입니다"
}

// Function Type 1.1 (String) -> String
func hello(userName: String) -> String {
    return "저는 \(userName)입니다"
}

// Function Type 2. (String, Int) -> String
func hello(nickname: String, userAge: Int) -> String {
    return "저는 \(nickname), \(userAge) 입니다"
}

// Function Type 2. () -> Void, () -> ()
// typealias Void = ()
func hello() {
    print("안녕하세요 반갑습니다.")
}

// 함수를 구분하기 힘들 때 타입 어노테이션을 통해 함수를 구별할 수 있다
let a: (String, Int) -> String = hello
// 하지만 Function1과 Function1.1 은 어떻게 구분? -> 함수의 식별자로 구분! (매개변수:) 가 식별자
// 함수의 식별자를 사용했다면, 타입 어노테이션을 생략하더라도 함수를 구별할 수 있다.
let b: (String) -> String = hello(nickname:)
let c: (String) -> String = hello(userName:)

// a 상수를 hello 함수처럼 사용할 수 있다
a("jihyun", 23)

// 2. 함수의 반환 타입으로 함수를 사용할 수 있다. 구조체 클래스 등 반환값으로 사용할 수 있음
// () -> String
func currentAccount() -> String {
    return "계좌 있음"
}

// () -> String
func noCurrentAccount() -> String {
    return "계좌 없음"
}

// 가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBack(bank: String) -> () -> String {
    // 계좌가 있는지 없는지
    let bankArray = ["우리", "KB", "신한"]
    return bankArray.contains(bank) ? currentAccount:noCurrentAccount
}

let jihyun = checkBack(bank: "농협") // 함수가 반환됨 함수 내부 호출하려면
jihyun() // 이렇게 호출을 해야겠지 !!

// 2-1. Calculate
func plus(a: Int, b: Int) -> Int {
    return a + b
}

func minus(a: Int, b: Int) -> Int {
    return a - b
}

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func divide(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand {
    case "+": return plus
    case "-": return minus
    case "*": return multiply
    case "/": return divide
    default: return plus
    }
}

// 가독성을 위해서 가급적 단계를 나눠 작성하는 편.
let result = calculate(operand: "-")(4,3)
//result(5,3)

/*
 3. 함수의 인자값으로 함수를 사용할 수 있다.
 콜백 함수로 자주 사용이 됨. 콜백 함수 : 특정 구문의 실행이 끝나면 시스템이 호출하도록 처리된 함수
 */

// () -> ()
func oddNumber() {
    print("홀수")
}

func evenNumber() {
    print("짝수")
}
    
func resultNumber(base: Int, odd: ()->(), even: ()->()) {
    return base.isMultiple(of: 2) ? odd() : even()
}

resultNumber(base: 9, odd: oddNumber, even: evenNumber)

func plusNumber() {
    print("더하기")
}

func minusNumber() {
    print("빼기")
}

// 어떤 함수가 들어가는 것과 상관 없이, 단지 타입만 잘 맞으면 된다.
// 실질적인 연산은 인자값으로 받는 함수에 달려있어서, 중개 역할만 담당한다고 하여 브로커라고 부른다고 합니다.
resultNumber(base: 9, odd: plusNumber, even: minusNumber)

// 익명함수
resultNumber(base: 9) {
    print("홀수")
} even: {
    print("짝수")
}

// 클로저의 유래. 외부함수 -> 내부함수 (클로저)

func drawingGame(item: Int) -> String {
    func luckyNumber(number: Int) -> String {
        return "\(item * number * Int.random(in: 1...5))"
    }
    
    let result = luckyNumber(number: item*2)
    
    return result
}

drawingGame(item: 10) // 외부 함수의 생명주기 -> 내부 함수의 생명주기(은닉성)

func drawingGame2(item: Int) -> (Int) -> String {
    func luckyNumber(number: Int) -> String {
        return "\(item * number * Int.random(in: 1...5))"
    }
    
    return luckyNumber
}

let luckyNumber2 = drawingGame2(item: 10) // 외부함수는 생명주기가 끝남 - 외부함수 매개변수 item 은?
// 처음 luckyNumber2를 선언할 때 item으로 넣었던 10을 **클로저 캡쳐** 를 통해 계속 사용할 수 있다

luckyNumber2(2) // 외부함수가 생명주기가 끝나더라도 내부 함수는 계속 사용할 수 있다.

// 은닉성이 있는 내부함수를 외부함수의 실행결과로 반환하면서 내부함수를 외부에서도 접근 가능하게 되었음. 이제 얼마든지 호출가능.
// 이건 생명 주기에도 영향을 미침. 외부함수가 종료되더라도 내부함수는 살아있다.
// 맨 처음만 실행되어야 하는 코드를 외부함수에 구현, 계속 쓸 코드를 내부함수로 구현

//**********
// 같은 정의를 갖는 함수가 서로 다른 환경을 저장하는 결과가 생기게 됨
// 클로저에 의해 내부 함수 주변의 지역 변수나 상수도 함께 저장됨 -> 값이 캡쳐되었다 라고 표현한다.
// 주변 환경에 포함된 변수나 상수의 타입이 기본 자료형이나 구조체 자료형일 때 발생함. 클로저 캡쳐 기본 기능

// => 스위프트는 특히 이름이 없는 함수로 클로저를 사용하고 있고, 주변환경(내부함수 주변의 변수나 상수)로부터 값을 캡쳐할 수 있는 "경량문법"으로 많이 사용하고 있다.

func studyiOS() {
    print("iOS 개발자를 위해 열공중")
}

let studyiOSHarder = {
    print("iOS 개발자를 위해 열공중")
}

let studyiOSHarder2 = { () -> () in // 여기서 () -> () 는 클로저의 타입
    print("iOS 개발자를 위해 열공중")
}

studyiOSHarder2()

func getStudyWithMe(study: () -> ()) {
    study()
}

// 인라인 클로저
getStudyWithMe(study: { () -> () in
    print("iOS 개발자를 위해 열공중")
})

getStudyWithMe(study: studyiOSHarder2)

// 트레일링 클로저
getStudyWithMe() { () -> () in
    print("iOS 개발자를 위해 열공중")
}

// ************* 다양한 클로저 표현 방식

func todayNumber(result: (Int) -> String) {
    result(Int.random(in: 1...100))
}

todayNumber(result: { (number: Int) -> String in
    return "행운의 숫자 \(number)"
})

todayNumber(result: { (number) in
    return "행운의 숫자 \(number)"
})

todayNumber(result: {
    return "행운의 숫자 \($0)"
})

todayNumber() { "\($0)" }


// 경량문법
todayNumber { value in
    print("하하하")
    return "\(value)입니다"
}

// @autoclosure @escaping
