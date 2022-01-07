//
//  ReactiveViewController.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/05.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import RxCocoa

struct SampleData {
    var user: String
    var age: Int
    var rate: Double
}

class ReactiveViewModel {
    
    var data = [
        SampleData(user: "Jack", age: 13, rate: 2.2),
        SampleData(user: "Hue", age: 14, rate: 4.2),
        SampleData(user: "Dustin", age: 15, rate: 3.2)
    ]
    
    // relay는 completed, error 안받음, next 가 아닌 accept
    // deinit 직접 해주어야 함
    
    var list = PublishRelay<[SampleData]>()
    
    func fetchData() {
        //list.onNext(data) // list에 데이터를 넣겠다
        list.accept(data)
    }
    
    func filterData(query: String) {
        let result = query != "" ? data.filter { $0.user.contains(query)} : data
        //list.onNext(result)
        list.accept(result)
    }
    
}

class ReactiveViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var viewModel = ReactiveViewModel()
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let resetButton = UIButton()
    
    // noti, delegate 등 없이 구현 o
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setup()
        
        // viewmodel data => tableview
        viewModel.list
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.user): \(element.age)세 (\(element.rate))"
                print("바인딩")
            }
            .disposed(by: disposeBag)
//        viewModel.list
//            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
//                cell.textLabel?.text = "\(element.user): \(element.age)세 (\(element.rate))"
//                print("바인딩")
//            }
//            .disposed(by: disposeBag)
        
        // subscribe - 백그라운드 쓰레드에서 동작할 경우도 있기 때문에 error, next, completed 분기처리에 적합
        // bind - 메인쓰레드에서 동작하기 때문에 UI적 구현에 좀 더 적합
        // drive - 바인드와 똑같이 메인에서 동작, stream ?? 데이터를 바로 쏴주는 형태라면 drive 사용 (drive은 relay와 보통 함께 쓰임)
        // scheduler 좀 더 공부

        // 버튼 클릭
        resetButton.rx.tap
            .subscribe { _ in
                self.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        
        // 서치바 텍스트가 변경될 때 이벤트 발생
        searchBar.rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(5), scheduler: MainScheduler.instance) // 사용자가 입력하고 나서 5밀리세컨 뒤에 방출 (빠르게 입력할 경우를 방지 - 사용자가 입력을 모두 멈추고 나서 맨마지막 것만 인식)
            .distinctUntilChanged() // 같은 값을 받지 않음 (오직 값이 변경될 때에만)
            .subscribe { value in
                self.viewModel.filterData(query: value.element ?? "")
            }
            .disposed(by: disposeBag)

    }
    
    func setup() {
        // 서치바를 네비게이션 바 안에
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(resetButton)
        resetButton.backgroundColor = .blue
        resetButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    func reactiveText() {
        
        var apple = 1
        var banana = 2
        
        print(apple + banana)
        
        apple = 10
        banana = 20
        
        let a = BehaviorSubject(value: 1)
        let b = BehaviorSubject(value: 2)
        
        Observable.combineLatest(a, b) {$0 + $1}
        .subscribe {
            print($0.element ?? 100)
        }
        .disposed(by: disposeBag)
        
        a.onNext(100)
    }
}


