//
//  PickerViewController.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PickerViewController: UIViewController {
    
    let pickerView = UIPickerView()
    let disposeBag = DisposeBag()
    let viewModel = ViewModel2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
         viewModel.items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self) // 클릭했어!
            .subscribe { value in // 구독 (선택한 것에 대한 이벤트 처리)
                print(value)
            }
            .disposed(by: disposeBag)
        // subscribe 종류 중 onNext , onError, onCompleted 매개변수가 함께있는 메서드를 확인할 수 있는데 이 메서드가 서버통신 시 성공, 에러 등의 분기처리를 할 수 있는 메서드!
        
        
        
        // bind VS subscribe -> bind는 다른 ui적 요소와 묶어 옵저버를 통해 값을 화면에 표시해줄 수 있음 / subscribe은 옵저버를 통해 선택된 값 혹은 성공 실패 여부에 대한 이벤트 처리를 내부적으로 수행할 수 있음
    }
    
    func setup() {
        view.addSubview(pickerView)
        pickerView.backgroundColor = .white
        pickerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}

class ViewModel2 {
    let items = Observable.just([
            "영화",
            "드라마",
            "애니메이션"
        ])
}
