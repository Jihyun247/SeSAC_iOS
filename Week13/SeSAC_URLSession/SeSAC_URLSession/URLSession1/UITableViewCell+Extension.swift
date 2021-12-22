//
//  UITableViewCell+Extension.swift
//  SeSAC_URLSession
//
//  Created by 김지현 on 2021/12/21.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
