import UIKit

var greeting = "Hello, playground"

class Guild {
    
    var guildName: String
    unowned var owner: User? // weak: 인스턴스 참조 시 RC를 증가시키지 않음.
    
    init(guildName: String) {
        self.guildName = guildName
        print("Guild init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

class User {
    
    var nickname: String
    var guild: Guild?
    
    init(nickname: String) {
        self.nickname = nickname
        print("User init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var sesac: Guild? = Guild(guildName: "SeSAC") // 옵셔널로 nil 넣을 수 있도록 한다 // RC 1
// sesac = nil // nil이 되면 메모리에 있을 필요가 없다고 판단하여 deinit 됨 // RC 0

var user1: User? = User(nickname: "jihyun") // RC 1
// user1 = nil // RC 0

// 메모리에 존재하지 않으면 옵셔널 ?에서 nil로 끝나게 된다
sesac?.owner = user1 // RC 2
user1?.guild = sesac // RC 2

// 순환참조 먼저 안끊어주면 메모리에 계속 남게 됨 따라서 서로를 참조하고 있는 것부터 해제해야함
// 1. 한 참조만 끊더라도 순환참조가 끊어지기 때문에 Guild, User 둘 다 메모리에서 해제 됨
sesac?.owner = nil // 1-1. User 참조 끊겨서 RC -1
user1 = nil // 1-2. User 삭제해서 RC -1 // 1-3. 참조중인 User가 삭제되어서 RC -1
sesac = nil // 1-4. Guild 삭제해서 RC -1
// 1-5. 그래서 결과적으로 둘 다 RC 0 이 된다.


// 인스턴스 nil 하기 전, 어느 하나를 먼저 nil => 맨날 어떻게 해?


// 2. guild의 user를 weak으로 설정할 경우 RC2가 아닌 RC1로 올라감
var swu: Guild? = Guild(guildName: "SWU")
var user2: User? = User(nickname: "merong")
swu?.owner = user2 // RC 1
user2?.guild = swu // RC 2

user2 = nil // 1-1. User 삭제해서 RC -1 -> Deinit // 1-2. 참조중인 User가 삭제되어서 RC -1
swu = nil // 1-3. Guild 삭제해서 RC -1


// 3. unowned 삭제하더라도 레퍼런스 카운트는 -1 되지만, 주소값을 계속 들고 있는다.
swu?.owner


// 그룹 프로퍼티 에 해당하는 인스턴스 하나를 만들어줌, 프로퍼티와 인스턴스는 연결하게 됨
// 힙 내의 인스턴스와 연결할 때마다 레퍼런스 카운트 RC가 +1이 된다.
// 만약 하나의 인스턴스가 두개의 프로퍼티와 연결되어 있다면 RC == 2

// https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html
