//
//  UILabel+Extension.swift
//  SeSAC_Week5_class
//
//  Created by 김지현 on 2021/10/29.
//

import Foundation
import UIKit

extension UILabel {
    func setBorderStyle() {
        self.backgroundColor = .blue
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
        
    }
}
