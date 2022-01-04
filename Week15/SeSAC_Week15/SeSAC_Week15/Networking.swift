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

class NetworkViewController: UIViewController {
    
    let label = UILabel()
    
    let mood = BehaviorSubject<String>(value: "오늘의 mood")
    
    let aztroURL = "https://aztro.sameerkumar.website?sign=virgo&day=today"
    let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // RXSwift5 까지는 디코딩 객체를 지원해주지 않아 연산자를 사용했어야 했다. 6부터 디코딩 연산자를 지원해주어 더 간편하게 사용할 수 있게 됨 (내일 수업)
        
        constraints()
        
        mood
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        json(.post, aztroURL)
            .subscribe { value in
                print(value)
                guard let data = value as? [String: Any] else {return}
                guard let result = data["mood"] as? String else {return}
                self.mood.onNext(result)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
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
    
    func useURLSession(url: String) -> Observable<String> { // 리턴으로 비동기 구현
        
        return Observable.create { observer in
            
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    return observer.onError(ExampleError.fail)
                }
                
                // response, data json, encoding 생략
                if let data = data, let json = String(data: data, encoding: .utf8) {
                    return observer.onNext("\(data)")
                }
                
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
}
