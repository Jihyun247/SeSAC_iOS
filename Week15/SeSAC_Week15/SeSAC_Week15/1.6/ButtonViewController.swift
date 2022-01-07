//
//  ButtonViewController.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ButtonViewController: UIViewController {
    
    var button = UIButton()
    var label = UILabel()
    
    var disposeBag = DisposeBag()
    var viewModel = ButtonViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        constraints()
        binding()
    }
    
    func setup() {
        [button, label].forEach { view.addSubview($0) }
        
        button.backgroundColor = .white
        label.backgroundColor = .lightGray
        label.textAlignment = .center
    }
    
    func constraints() {
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
    
    func binding() {
        
//        button.rx.tap
//            .bind(to: { _ in
//                self.label.text = self.viewModel.labelText.value
//            })
//            .disposed(by: disposeBag)
    
//    func binding() {
//        button.rx.tap
//            .subscribe { _ in
//                self.label.text = self.viewModel.labelText.value
//            }
//            .disposed(by: disposeBag)
        
        //        button.rx.tap
        //            .map{"안녕 반가워"}
        //            .bind(to: label.rx.text)
        //            .disposed(by: disposeBag)
                
        //        button.rx.tap
        //            .map {"안녕 반가워"}
        //            .asDriver(onErrorJustReturn: "")
        //            .drive(label.rx.text)
        //            .disposed(by: disposeBag)

        
        let input = ButtonViewModel.Input(tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.text
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        // 서버통신, 디코딩, 얻어내기, map 로직 모두 뷰모델에서 처리
    }
}
