//
//  ViewController.swift
//  SeSAC_Week16
//
//  Created by 김지현 on 2022/01/10.
//

import UIKit

protocol myProtocol: AnyObject { // 프로토콜이자 typealias
    // 마이프로토콜이 클래스에서만 동작한다는 것을 알 수 있음
    
}

enum GameJob {
    case warrior
    case rogue
}

class Game {
    var level = 5
    var name = "도사"
}

class ViewController: UIViewController {

    // 1-1. 런타임 시점에 결정되기 때문에 any로 설정하면, 버튼 메서드들을 사용할 수 없음
    @IBAction func buttonClicked(_ sender: Any) {
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
        // 1-2. 버튼, 텍필, 탭제스쳐 셋 모두 공통적으로 키보드 내리는 기능을 사용하고 싶다면 sender를 any로 설정하는 것이 하나의 방법
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyOnWrite()
    }
    
    // 1. AnyObject vs Any
    // 런타임 시점에 타입이 결정 -> 런타임 오류
    // 컴파일 시점에서 알 수 없음.
    // Any: Class, Struct, Enum, Closure ...
    // AnyObject: Class
    func aboutAnyObject() {
        
        let name = "고래밥"
        let gender = false
        let age = 10
        let characters = Game()
        
        let anylist: [Any] = [name, gender, age, characters]
        let anyObjectList: [AnyObject] = [characters]
        // 1-3. 나머지 값들은 구조체라서 anyObjectList에 못들어감, 오직 클래스만!
        if let value = anylist[0] as? String {
            print(value)
        }
    }
    
    // 2. 수정되기 전까지 원본을 공유 -> 복사 (Collection Type)
    func copyOnWrite() {
        
        // 2-1. -- 구조체 중 값 변수 특징 --
//        var nickname = "jihyun"
//       print( address(of: &nickname))
//        var nicknameByFam = nickname
//        print(address(of: &nicknameByFam))
//        nicknameByFam = "젼"
//        print(address(of: &nicknameByFam))
//        print(nickname, nicknameByFam)
        
        // 2-2. -- 구조체 중 컬렉션 타입 특징 --
        // newArray가 array의 주소를 참조한다. 분명 복사가 되어야 하는데 ..!
        // 원본과 데이터가 달리지기 전까진 굳이 불필요한 메모리를 또 소비할 필요 없기 때문에 원본을 참조하는 것
        // 그래서 newArray의 정보가 달라지면 그 때 새로운 주소로 복사하게 된다.
        var array = Array(repeating: 100, count: 100)
        print(address(of: &array))
        var newArray = array
        print(address(of: &newArray))
        
        newArray[0] = 0
        print(address(of: &newArray))
        
        var game = Game()
        
        var newGame = game
        
        newGame.level = 595
        
        print(game.level, newGame.level)
    }
    
    func address(of object: UnsafeRawPointer) -> String {
        let address = Int(bitPattern: object)
        return String(format: "%p", address)
    }
    
    // 3. subscript
    func aboutSubscript() {
        
//        let array = [1,2,3,4,5]
//        array[2]
//        let dic = ["도사": 393, "도적": 300]
//        dic["도사"]
        
        // 3-1. 스트링 타입은 서브스크립트를 따르지 않음 따라서 str[0] 인식 못함
        let str = "Hello World"
        print(str[2], str[8])
        
        // 3-3.
        struct UserPhone {
            var numbers = ["01094294356", "01049410917", "01079294356"]
            
            subscript(idx: Int) -> String {
                get {
                    return self.numbers[idx]
                }
                set {
                    self.numbers[idx] = newValue
                }
            }
        }
        
        var value = UserPhone()
        print(value[0])
        value[1] = "1234"
        print(value[1])
    }
    
    // 4. for - in VS forEach
    func aboutForEach() {
        
        let array = [1,2,3,4,5,6,7,8,9]
        
        // for - in은 특정 조건에 대한 Break 가능
        for i in array {
            if i == 5 { break }
            print(i)
        }
        
        // forEach는 클로저를 반환하기 때문에 중간에 break, continue 불가
        array.forEach { i in
            print(i)
        }
    }
    
    // 5. enum
    // 라이브러리, 프레임워크
    // @frozen - 가능성 x
    // Unfrozen Enumeration : 계속 추가될 수 있는 가능성을 가진 열거형
    // @unknown: default
    func aboutEnum() {
        
        let size = UIUserInterfaceSizeClass.compact
        
//        switch size {
//            
//        case .unspecified:
//            <#code#>
//        case .compact:
//            <#code#>
//        case .regular:
//            <#code#>
//        @unknown default:
//            <#code#>
//        }
    }
}

extension String {
    
    // 3-2. 오.. 원랜 스트링에 서브스크립트 없는데 (컬렉션 타입만 있음) extension 해줌
    subscript(idx: Int) -> String? {
        get {
            guard (0..<count).contains(idx) else {
                return nil
            }
            let result = index(startIndex, offsetBy: idx)
            return String(self[result])
        }
    }
}

