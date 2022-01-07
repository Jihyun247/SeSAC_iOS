//
//  TempViewController.swift
//  SeSAC_URLSession
//
//  Created by 김지현 on 2021/12/24.
//

// [커서 복수개] - shift + ctrl + click
// [문장 위치 change] - option + command + []
// [원하는 위치의 문장들만 드래그 가능] - shift + ctrl + 방향키
// [초기화] - Editor -> refactor -> generate memberwise initailizer / refactor -> add equatable conformance
// [interface] - ctrl + command + up
// [중괄호 닫기] - option + command < >
// [문법잡기] - edit -> format -> spelling and grammar
// [중괄호 맞추기 ?] - Ctrl + I
// [커서 위치 찾기] - option + cmd + L
// [code snippets] - ~/Library/Developer/Xcode/UserData/CodeSnippets 놑북 바꿀 때

// [시뮬레이터 팁 by WWDC]
// https://developer.apple.com/videos/play/wwdc2020/10647/
// 시뮬레이터 -> debug - slow animations

import UIKit

class TempViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }
    
    // [함수나 클래스 설명] - option + cmd + /
    /// - parameters message : asdfasdf
    /// - important: hello
    /// - returns: 닉네임 전달해야 함
    /// - 사용자 정보
    ///     - 닉네임 최소 3자 이상 8자까지 가능, **숫자 불가**
    ///     - 나이: 한국 나이 사이트 참고 [바로가기](https://www.apple.com)
    func example() {
        
    }
}

class User {
    
    internal init(name: String, age: Int, email: String, review: String) {
        self.name = name
        self.age = age
        self.email = email
        self.review = review
    }
    
    var name: String
    var age: Int
    var email: String
    var review: String
}
