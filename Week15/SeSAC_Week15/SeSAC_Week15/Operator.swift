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
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1-1. Observable: Create (이벤트를 만드는 기능)
        // 1-2. just, of, from 같은 메서드를 사용해서 create를 좀 더 간편하게 사용 !
        // 2. Subscribe: 이벤트 처리하기 위한 이벤트 인식
        // 3. next (아무 문제 없이 다음단계 실행, next가 모두 끝나면 completed) & completed (완료 후 이벤트 사라짐) & error
        // 4. disposed: 뷰컨이 가지고 있는 여러 이벤트에 대한 데이터들을 deinit 처리해준다
        // completed 되지 않고 계속 실행중인 상태에서 다른 뷰로 이동할 시 ! deinit 처리를 해주는 것이 필요하기 때문에 disposed
        
        Observable.from(["가", "나", "다", "라", "마"])
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
            
        let intervalObservable = Observable<Int>.interval(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("interval disposed")
            }
            .disposed(by: disposeBag)
        
        let repeatObservable = Observable.repeatElement("Jihyun")
            .take(Int.random(in: 5...10))
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("interval disposed")
            }
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            //self.navigationController?.pushViewController(GradeCalculator(), animated: true)
            //self.present(GradeCalculator(), animated: true, completion: nil)
            
            //self.dismiss(animated: true, completion: nil)
            
//            intervalObservable.dispose()
//            repeatObservable.dispose()
            // 이렇게 하면 observable이 많아질 때 귀찮아짐
            
            self.disposeBag = DisposeBag()
            // 루트뷰에서 사용되는 옵저버블을 이렇게 처리할 필요 O -> 사용되던 disposeBag 교체가 됨
        }
        // disposed 해주었는데도 GradeCalculator()로 가도 계속 interval 옵저버블이 실행되는 이유 : 네비게이션컨트롤러는 뒤로갈 수 있기 때문에 루트뷰가 계속 살아있다.
        // 근데 present를 해주어도 살아있음. dismiss가 발생하지 않는한 메모리가 계속 살아있는 것
    }
    
    deinit {
        print("Operator deinit")
    }
    
    func basic() {
        
        let items = [3.3, 4.0, 5.0, 3.6, 4.8]
        let itemsB = [3.3, 4.0, 5.0, 3.6, 4.8]
        
        
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
        
        
        
        Observable.of(items, itemsB)
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
