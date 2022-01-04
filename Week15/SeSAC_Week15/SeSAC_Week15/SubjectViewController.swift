//
//  SubjectViewController.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/04.
//

import UIKit
import SnapKit
import RxSwift

class SubjectViewController: UIViewController {
    
    let label = UILabel()
    
    let nickname = PublishSubject<String>() //Observable.just("jihyun")
    // 전달도 할 수 있고 처리도 할 수 있는 PublishSubject ? ObservableType, ObserverType 모두를 가지고 있다
    // 자신이 가지고 있는 값을 구독을 할 수도 있고, 전달할 수도 있는 것이다.
    
    let disposeBag = DisposeBag()
    
    // ------
    
    let array1 = [ 1,1,1,1,1,1 ]
    let array2 = [ 2,2,2,2,2,2 ]
    let array3 = [ 3,3,3,3,3,3 ]
    
    let subject = PublishSubject<[Int]>()
    let behavior = BehaviorSubject<[Int]>(value: [0,0,0,0,0])
    let replay = ReplaySubject<[Int]>.create(bufferSize: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let random1 = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            
            return Disposables.create()
        }
        
        random1
            .subscribe { value in
                print("random1 \(value)")
            }
            .disposed(by: disposeBag)
        
        random1
            .subscribe { value in
                print("random2 \(value)")
            }
            .disposed(by: disposeBag)
        
        let randomSubject = BehaviorSubject(value: 0)
        randomSubject.onNext(Int.random(in: 1...100))
        
        randomSubject
            .subscribe { value in
                print("randomSubject1 \(value)")
            }
            .disposed(by: disposeBag)
        
        randomSubject
            .subscribe { value in
                print("randomSubject2 \(value)")
            }
            .disposed(by: disposeBag)
    }
    
    func replaySubject() {
        
        replay.onNext(array1)
        replay.onNext(array2)
        replay.onNext(array3)
        replay.onNext([1,2,3,4,5])
        
        replay
            .subscribe { value in
                print("replay subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }
            .disposed(by: disposeBag)
        
        replay.onNext([5,6,7,8,9])
    }
    
    func behaviorSubject() {
        
        behavior.onNext(array3)
        behavior.onNext(array2)
        behavior.onNext(array1)
        // 마지막 array1만 살아남음 ㅋㅋ
        
        // subject는 초기값이 없다. 그래서 처음부터 전달할 값이 없음. behavior은 초기값이 있기 때문에, 굳이 next로 값을 전달하지 않아도 구독하자마자 초기값 전달됨
        behavior
            .subscribe { value in
                print("behavior subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }
            .disposed(by: disposeBag)
    }
    
    func publishSubject() {
        
        subject.onNext(array1) // 이벤트 전달 안됨 (구독 전)
        
        subject // 구독을 해야 이벤트 전달이 됨 !
            .subscribe { value in
                print("publish subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }
            .disposed(by: disposeBag)
        
        subject.onNext(array2) // 이벤트 전달 됨 (구독 후)
        subject.onNext(array3)
        subject.onCompleted() // 끝!
        subject.onNext(array1) // 이벤트 전달 안됨 (완료 시점 이후)

        // bind는 complete, error 처리 x
    }
    
    func aboutSubject() {
        
        setup()
        
        nickname
            .bind(to: label.rx.text) // subscribe vs bind vs drive -> 이벤트에 대한 처리의 유효 ? + drive은 스트림 공유
            .disposed(by: disposeBag)
        
        // 변경을 감지해야하기 때문에 nickname에 바로 할당하는 것이 아니라 onNext 이용
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.nickname.onNext("maerong")
        }
    }
    
    func setup() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.backgroundColor = .white
        label.textAlignment = .center
    }
}
