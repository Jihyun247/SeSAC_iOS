//
//  ExampleViewController.swift
//  exercise9
//
//  Created by 김지현 on 2021/10/08.
//

import UIKit

enum GameJob {
    case rogue, warrior, mystic, shaman, fight
}

class ExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let random: [UIColor] = [.red, .black, .gray, .green]
//        view.backgroundColor = random.randomElement()
        
        view.backgroundColor = setViewBackground()
        
        // 반환값만 사용하지 않고 함수 내의 코드들만 실행되어도 괜찮을 때 @discardableResult 를 사용한다 !!
         setViewBackground()
        
        var selectJob: GameJob = .rogue
        
        switch selectJob {
        case .rogue:
            print("도적")
        case .warrior:
            print("")
        case .mystic:
            print()
        case .shaman:
            print()
        case .fight:
            print()
        }
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        // 1. UIAlertController 생성 : 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: "타이틀 테스트", message: "메시지가 입력되었습니다.", preferredStyle: .actionSheet)
        // preferredStyle 도 enum 으로 만들어짐 (alert, action sheet)
        let alertNil = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        // 2. UIAlertAction 생성 : 버튼들
        let sad = UIAlertAction(title: "힘들다", style: .default)
        let sad2 = UIAlertAction(title: "힘들다2", style: .default)
        let jonbeo = UIAlertAction(title: "존버", style: .cancel)
        let fighting = UIAlertAction(title: "화이팅", style: .destructive)
        
        // 3. 1+2
        alertNil.addAction(sad)
        alertNil.addAction(sad2)
        alertNil.addAction(jonbeo)
        alertNil.addAction(fighting)
        
        // 4. Present
        // present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        // viewControllerToPresent 속성이 UIViewController 이어야 한다 ! 하지만 여기서 UIAlertController가
        // UIViewController를 상속받은 객체이기 때문에 쓸 수 있는 것
        present(alertNil, animated: true, completion: nil)
        
        // UIColorPicker vc
//        let colorPicker = UIColorPickerViewController()
//        present(colorPicker, animated: true, completion: nil)
    }
    
    
    @discardableResult func setViewBackground() -> UIColor? {
        // 왜 함수 내에서는 오류가 뜨지 ? random element를 부르게 되면 반환 값이 옵셔널 타입이 된다. nil 값이 들어갈 수도 있는 상황인 것!
        // return 값은 uicolor 옵셔널 타입이지만, 함수 반환 자료형을 uicolor형으로 지정해놓았기 때문에 오류가 난다
        // 해결방법1 : 반환값의 타입을 옵셔널 타입으로 변경 : UIColor => UIColor?
        // 해결방법2 : 반환될 값을 강제 해제 radom.randomElement()!
        // 해결방법3 : nil 값일 때 분기처리 : ex. random.randomElement() ?? UIColor.yellow
        
        let random: [UIColor] = [.red, .black, .gray, .green]
        return random.randomElement()
    }
}
