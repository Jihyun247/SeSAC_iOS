import UIKit

// 클래스가 인스턴스로 되기 위해서는, 클래스의 프로퍼티가 모두 초기화 되어 있어야 한다. 그래서 옵셔널 타입 사용
// 프로퍼티가 옵셔널일 경우, 컴파일 오류는 나지 않지만 런타임 오류는 발생할 수 있다.
// 변수 선언 시 초기화해야한다. '초기화' - init

// 클래스
class Monster {
    // 프로퍼티
    var clothes: String
    var speed: Int
    var power: Int
    var exp: Double

    // 초기화 , 여기서 self는 Monster 클래스를 말함
    init(clothes: String, speed: Int, power: Int, exp: Double) {
        self.clothes = clothes
        self.speed = speed
        self.power = power
        self.exp = exp
    }
    
    // 메서드
    func attack() {
        print("몬스터 공격!!")
    }
}

// Monster 상속 받음
class BossMonster: Monster {
    
    var bossName = "끝판왕보스"
    
    override func attack() {
        super.attack()
        print("보스만의 강력한 공격!!")
    }

}

//// 구조체
//struct Monster {
//    // 프로퍼티
//    var clothes: String
//    var speed: Int
//    var power: Int
//    var exp: Double
//
//    // 왜 struct에서는 init을 지워도 오류가 안날까?
//    // struct는 초기화를 하지 않고 변수와 자료형만 사용하여 프로퍼티를 만들어 놓으면
//    // 해당 struct 사용 시 초기화 구문을 자동으로 제공해준다. -> (Property + Method) = Member
//    // struct는 멤버와이즈 초기화 구문 제공 = Memberwise initialize
//}

// 클래스와 구조체의 가장 큰 차이 : 클래스는 상속 가능, 구조체는 불가능
// UIView로 된 거의 모든 오브젝은 상속이 되어 있기 때문에 (ex. UILabel) 클래스로 이루어짐

// 인스턴스 (easyMonster, hardMonster) // 밑 두문장이 멤버와이즈 초기화 구문
var easyMonster = Monster(clothes: "Orange", speed: 1, power: 10, exp: 50.0)
var hardMonster = Monster(clothes: "Blue", speed: 10, power: 500, exp: 10000)

var boss = BossMonster(clothes: "black", speed: 100, power: 500000, exp: 2000000)
boss.bossName
boss.clothes
boss.attack()

// Value Type VS Reference Type

var nickname: String = "고래밥"
var subNickname = nickname
nickname = "칙촉"

class SuperBoss {
    var name: String
    var level: Int
    var power: Int
    
    init(name: String, level: Int, power: Int) {
        self.name = name
        self.level = level
        self.power = power
    }
}

var hardStepBoss = SuperBoss(name: "쉬운 보스", level: 1, power: 10)

// 클래스일 경우 - 같은 주소를 공유하게 된다. 할당받은 객체의 내용이 달라지면 똑같이 달라진다.
// 구조체일 경우 - 할당 받는 메모리 공간이 다르다 ! 주소가 다르기 때문에 내용만 똑같고 다른 객체가 됨
var easyStepBoss = hardStepBoss

hardStepBoss.power = 50000
hardStepBoss.level = 100
hardStepBoss.name = "어려운 보스"

print(hardStepBoss.name, hardStepBoss.level, hardStepBoss.power)
print(easyStepBoss.name, easyStepBoss.level, easyStepBoss.power)
