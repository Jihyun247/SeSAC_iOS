//
//  String+Extension.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/01.
//

import Foundation

extension String {
    
//    var localized: String {
//        get {
//            return NSLocalizedString(self, comment: "")
//        }
//    }
    
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: .main, value: "", comment: "")
    }
}
