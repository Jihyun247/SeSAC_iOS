//
//  ButtonViewModel.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/06.
//

import UIKit
import RxSwift
import RxCocoa

class ButtonViewModel: CommonViewModel {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let result = input.tap
            .map { "안녕 반가워" }
            .asDriver(onErrorJustReturn: "")
        
        return Output(text: result)
    }
    
    var labelText = BehaviorRelay<String>(value: "안녕 반가워!")
    
    func buttonTapped() {
        labelText.accept("안녕 반가워")
    }
    
    // 탭을 문자열로 변경하고 레이블에 띄워주는 것을
    // 뷰모델을 사용하기
}
