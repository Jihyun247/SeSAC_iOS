//
//  ViewController.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/03.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let label = UILabel()
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        // Observer
        viewModel.items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        // bind - Observable & Observer 연결
        
        tableView.rx.modelSelected(String.self)
            .map({ data in
                "\(data)를 클릭했습니다!"
            })
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.async {
            self.present(Operator(), animated: true, completion: nil)
        }
    }
    
    func setup() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // 코드로 테이블, 콜렉션 만들 때 identifier가 필요할 경우 register로 ,,
        
        view.addSubview(label)
        label.backgroundColor = .lightGray
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}

class ViewModel {
    // Observable
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
}

