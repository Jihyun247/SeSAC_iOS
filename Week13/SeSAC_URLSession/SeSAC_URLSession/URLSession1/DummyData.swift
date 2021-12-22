//
//  DummyData.swift
//  SeSAC_URLSession
//
//  Created by 김지현 on 2021/12/21.
//

import UIKit

class DummyViewModel: TableViewCellRepresentable {
    
    var data: [String] = Array(repeating: "테스트", count: 100)
    
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRowsInSection: Int {
        return data.count
    }
    
    var heightOfRowAt: CGFloat {
        return 60
    }
    
    func cellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
