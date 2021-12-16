import UIKit

// 함수 매개변수
func sayHello() -> String {
    print("안녕하세요")
    
    return "안녕하세요 반갑습니다!"
}

print("자기소개 : \(sayHello())")

func bmi() -> Double {
    // 조건문
    
    return 20.1
}

func bmiResult() -> [String] {
    let name = "고래밥"
    let result = "정상"
    
    return [name, result]
}

let value = bmiResult()
print(value[0], value[1])

// 컬렉션 (집단 자료형) : 배열, 딕셔너리, 집합+튜플
let userInfo: (String, String, Bool, Double) = ("고래밥", "j1hyun@naver.com", true, 4.5)

print(userInfo.0)

// Swift5.1 return 키워드 생략 가능 - 함수에 어떤 연산도 없이 리턴만 할 때 !
//func getMovieReport() -> (Int, Int) {
//    return (1000, 30000)
//}
//func getMovieReport() -> (Int, Int) {
//    (1000, 30000)
//}

// @discardableResult 반환값을 무시하는 기능
@discardableResult func getMovieReport() -> (Int, Int) {
    (1000, 30000)
}

// 열거형
enum AppleDevice {
    case iPhone
    case iPad
    case watch
}

enum GameJob: String {
    case rogue = "도적"
    case warrior = "전사"
    case mystic = "도사"
    case shaman = "주술사"
    case fight = "격투가"
}

let selectJob: GameJob = .mystic

print("당신은 \(selectJob.rawValue)입니다.")

if selectJob == GameJob.mystic {
    print("당신은 도사입니다.")
} else if selectJob == .shaman {
    print("당신은 주술사입니다.")
}

enum Gender {
    // case 생략하고 쉼표로 나열해서 한줄로 표현 가능
    case man, woman
}

// 실질적인 값 지정 가능
//enum HTTPCode: Int {
//    case OK = 200
//    case SERVER_ERROR = 500
//    case NO_PAGE // 501이 됨
//}
//
//var status: HTTPCode = .OK
//print(status.rawValue) // 원시값
//
//if status == .NO_PAGE {
//    print("잘못된 주소입니다.")
//} else if status == .SERVER_ERROR {
//    print("서버 점검중입니다.")
//}

enum HTTPCode: Int {
    case OK = 200
    case SERVER_ERROR = 500
    case NO_PAGE // 501이 됨
    
    func showStatus() -> String {
        // self => enum 의 케이스들 가져올 수 있음
        switch self {
        case .NO_PAGE:
            return "잘못된 주소입니다."
        case .SERVER_ERROR:
            return "잘못된 주소입니다."
        case .OK:
            return "정상입니다."
        }
    }
}

var status: HTTPCode = .NO_PAGE
print(status.showStatus())
