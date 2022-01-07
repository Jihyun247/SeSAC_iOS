//
//  Networking.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/04.
//

import UIKit
import RxSwift
import RxAlamofire
import SnapKit

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

class NetworkViewController: UIViewController {
    
    let label = UILabel()
    
    let number = BehaviorSubject<String>(value: "")
    
    let aztroURL = "https://aztro.sameerkumar.website?sign=virgo&day=today"
    let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constraints()
        
        // 네트워크 통신처럼 비동기 구문이 들어오면 백그라운드에서 동작하게 되고 subscribe 등이 모두 백그라운드로 가는 것 따라서 ui요소는 메인쓰레드로 빼줘야 한다
        // 방법은 1. bind 사용 (항상 메인) 2. dispatch queue 3. observe on & subscribe on
        
        // 1. bind 사용 (항상 메인)
        number
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        // 2. dispatch queue
        number
            .subscribe { value in
                DispatchQueue.main.async {
                    self.label.text = value
                }
            }
            .disposed(by: disposeBag)
        
        // 3. observe on & subscribe on
        number
            .observe(on: MainScheduler.instance) // observe on vs subscribe on
            .subscribe { value in
                self.label.text = value
            }
            .disposed(by: disposeBag)
        
        // observe on 은 메인 - 백 - 메인 - 백 왔다갔다 하도록 한번에 연쇄적으로 쓸 수 있는 반면 subscribe on 은 한 번만 쓰도록
//        number
//            .map { <#String#> in
//                <#code#>
//            }
//            .observe(on: MainScheduler.instance)
//            .map { <#()#> in
//                <#code#>
//            }
        
        
        let request = useURLSession(url: lottoURL)
            .share() // 구독할 때마다 생기던 옵저버들이 하나를 가지고 공유하게 됨 / share하지 않았을 땐 11,22 형태 share 하면 12,12 형태
            .decode(type: Lotto.self, decoder: JSONDecoder())
        
        request
            .subscribe { value in
                print("value1") // 두번 호출되는 이유는 next 한번, completed 한번
            }
            .disposed(by: disposeBag)
        
        request
            .subscribe { value in
                print("value2")
            }
            .disposed(by: disposeBag)


        
    }
    
    func constraints() {
        view.addSubview(label)
        label.backgroundColor = .white
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func useURLSession(url: String) -> Observable<Data> { // 리턴으로 비동기 구현
        
        return Observable.create { observer in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    observer.onError(ExampleError.fail)
                    return
                }
                // response, data json, encoding 생략
                if let data = data {
                    print("datatask")
                    observer.onNext(data)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    func rxAlamofire() {
        
        json(.post, aztroURL)
            .subscribe { value in
                print(value)
                guard let data = value as? [String: Any] else {return}
                guard let result = data["mood"] as? String else {return}
                self.number.onNext(result)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }
            .disposed(by: disposeBag)
    }
    
}
