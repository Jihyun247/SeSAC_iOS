//
//  ViewController.swift
//  SeSAC_URLSession
//
//  Created by 김지현 on 2021/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    var apiService = APIService()
    
    var castData: Cast?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        
        apiService.requestCast { cast in
            self.castData = cast
            
            print(Thread.isMainThread)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (castData?.peopleListResult.peopleList.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier:  UITableViewCell.reuseIdentifier)
        cell?.textLabel?.text = castData?.peopleListResult.peopleList[indexPath.row].peopleNm
        cell?.detailTextLabel?.text = "aaaa"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//class testCell: UITableViewCell {
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        <#code#>
//    }
//}
