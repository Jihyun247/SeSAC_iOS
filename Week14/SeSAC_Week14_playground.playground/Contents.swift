import UIKit

class Observable<T> {
    private var listener: ( (T) -> Void )?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

class User<T> {
    
    // 3. 옵셔널 형태로 선언
    var listner: ((T) -> Void)?
    
    // 1. didSet을 통해 name이 변경되었을 때 감지
    var name: T {
        didSet {
            listner?(name)
        }
    }
    
    // 2. 초기화 구문
    init(_ name: T) {
        self.name = name
    }
    
    // 4. changedName을 호출하게 되면 completion이 실행 되면서 리스너도 함께 nil이 아니게 된다 ! name 변경 시 didSet이 실행 되며 리스너도 실행됨
    func changedName(_ completion: @escaping (T) -> Void) {
        print("이름이 변경되었습니다")
        completion(name)
        listner = completion
    }
}

let jack = User("고래밥")
jack.name = "칙촉"

// 1. 옵저버블 초기화 시 클래스 부르고 특정 값 넣었는데 이것은 초기화 구문에서 온 것을 알 수 있다 !
// 2. 변수가 변경된 것을 감지하고 싶다면 name 변수에 didset을 활용












func hello(name: String, age: Int) -> String {
    return "\(name): \(age)"
}

// 1. 반환 값이 String이기 때문에 String 타입 선언 가능
let a: String = hello(name: "고래밥", age: 2)
type(of: a)

// 2-1. 함수 자체를 b에 할당
// 2-2. 함수가 (String, Int) -> String 형태이기 때문에 이와 같이 타입 선언 가능
let b: (String, Int) -> String = hello

// 3. 옵셔널 형태로 선언
var listner: ((String, Int) -> String)?

// 4. 아래와 같은 함수는 (() -> Void) 형태의 함수
func ex() {
    
}













//struct Endpoint {
//    static let baseURL = "http://test.monocoding.com/"
//    
//    static let signup = baseURL + "auth/local/register"
//    static let login = baseURL + "auth/local"
//    static let board = baseURL + "board"
//}

enum Endpoint {
    case signup
    case login
    case boards
    case boardDetail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
            
        case .signup:
            return .makeEndpoint("auth/local/register")
        case .login:
            return .makeEndpoint("auth/local")
        case .boards:
            return .makeEndpoint("boards")
        case .boardDetail(let id):
            return .makeEndpoint("board/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com/"
    
    static func makeEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
    
//    static var login: URL {
//        return makeEndpoint("auth/local")
//    }
//
//    static var signup: URL {
//        return makeEndpoint("auth/local/register")
//    }
//
//    static var boards: URL {
//        return makeEndpoint("boards")
//    }
//
//    static func boardDetail(num: Int) -> URL {
//        return makeEndpoint("board/\(id)")
//    }
    
    
}

URLSession.shared.dataTask(with: Endpoint.signup.url)
print(Endpoint.signup.url)







class A {
    
    static func a() { // 타입 메서드
        
    }
    
    class func b() { // 타입 메서드 - overriding 가능
        
    }
    
    final class func finalb() { // 타입 메서드 - final 붙이면 static과 똑같, 오버라이딩 불가
        
    }
    
    func c() { // 인스턴스 메서드 - 얘를 호출하려면 클래스 인스턴스를 초기화해서 호출해야 한다
        
    }
}

A().c()
A.a()
A.b()

class B: A {
    override class func b() {
        <#code#>
    }
}

// 접근제어자를 쓰지 않으면 default는 internal
// WMO가 하는 역할은 여러가지 파일을 하나의 파일처럼 확인하는 역할
// public - 재정의 불가, open - 재정의 가능 (dynamic)
// public 클래스 내의 private 메서드가 있다면 그 메서드에 한해 최적화가 진행됨 ( to static )
