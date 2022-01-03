//
//  Operator.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/03.
//

import Foundation
import UIKit
import RxSwift

enum ExampleError: Error {
    case fail
}


class Operator: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = [3.3, 4.0, 5.0, 3.6, 4.8]
        
        
        
        Observable<Double>.create { observer -> Disposable in
            
            for i in items {
                if i < 3.0 {
                    observer.onError(ExampleError.fail)
                    break
                }
                observer.onNext(i)
            }
            observer.onCompleted()
            
            return Disposables.create()
        }.subscribe { value in
            print(value)
        } onError: { error in
            print(error) // alert 띄운다던가..
        } onCompleted: {
            print("completed") // 완료된 이후의 처리
        } onDisposed: {
            print("disposed")
        }
        .disposed(by: disposeBag)
        // 1. observable create 후 subscribe을 하여 next->completed 혹은 error 처리를 해주는 과정으로 연결된다.
        
        
        
        Observable.just(items)
            .subscribe { value in
                print("just - \(value)")
            }
            .disposed(by: disposeBag)
        // 2. create 대신 just를 통해 좀 더 간편하게 이용 가능
        
        
        
        Observable.of(items)
            .subscribe { value in
                print("of - \(value)")
            }
            .disposed(by: disposeBag)
        // 3. just VS of -> of는 두개의 배열을 전달할 때 사용 가능
        
        
        
        Observable.from(items)
            .subscribe { value in
                print("from - \(value)")
            }
            .disposed(by: disposeBag)
        // 3. from -> 각각의 element가 별도로 전달됨 각각 처리 가능
        
    }
}
