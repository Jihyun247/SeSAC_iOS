//
//  GradeCalculator.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class GradeCalculator: UIViewController {
    
    let myswitch = UISwitch()
    let firstTf = UITextField()
    let secondTf = UITextField()
    let resultLabel = UILabel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        //
        Observable.combineLatest(firstTf.rx.text.orEmpty, secondTf.rx.text.orEmpty) { textValue1, textValue2 -> String in
            
            return String(((Double(textValue1) ?? 0.0) + (Double(textValue2) ?? 0.0)) / 2)
        }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
        
        Observable.of(true)
            .bind(to: myswitch.rx.isOn)
            .disposed(by: disposeBag)
    }
    
    func setup() {

        view.addSubview(myswitch)
        myswitch.tintColor = .systemPink
        myswitch.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(firstTf)
        firstTf.backgroundColor = .white
        firstTf.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(50)
        }
        
        view.addSubview(secondTf)
        secondTf.backgroundColor = .white
        secondTf.snp.makeConstraints { make in
            make.top.equalTo(firstTf.snp.bottom).offset(50)
            make.size.equalTo(50)
            make.leading.equalTo(50)
        }
        
        view.addSubview(resultLabel)
        resultLabel.backgroundColor = .white
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(secondTf.snp.bottom).offset(50)
            make.size.equalTo(50)
            make.leading.equalTo(50)
        }
        
        
    }
}
