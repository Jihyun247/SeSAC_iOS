//
//  ValidationViewController.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/05.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag{get set}
    
    func transform(input: Input) -> Output
}

class ValidationViewModel: CommonViewModel {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    
    struct Input {
        let text: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let resultText = input.text
            .orEmpty
            .map{$0.count >= 8}
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validStatus: resultText, validText: validText, sceneTransition: input.tap)
    }
    
    var validText = BehaviorRelay<String>(value: "최소 8자 이상 필요해요")
}

class ValidationViewController: UIViewController {
    
    let nameValidationLabel = UILabel()
    let nameTextField = UITextField()
    let button = UIButton()
    
    var viewModel = ValidationViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingWithInputOutput()
    }
    
    func binding() {
        let validation = nameTextField.rx.text
            .orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1, scope: .whileConnected) // 버퍼에 대한 사이즈 .. 매개변수 서칭해보기
        
        validation
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        validation
            .bind(to: nameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.validText
            .asDriver()
            .drive(nameValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe { _ in
                self.present(ReactiveViewController(), animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    func bindingWithInputOutput() {
        let input = ValidationViewModel.Input(text: nameTextField.rx.text, tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: button.rx.isEnabled, nameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.validText
            .asDriver()
            .drive(nameValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                self.present(ReactiveViewController(), animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    func setup() {
        [nameValidationLabel, nameTextField, button].forEach {
            $0.backgroundColor = .white
            view.addSubview($0)
        }
        nameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(300)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}
