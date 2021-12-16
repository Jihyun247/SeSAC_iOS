//
//  LocalizableStrings.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/01.
//

import Foundation


// 열거형에서의 rawValue
enum LocalizableStrings: String {
    case welcome_text
    case data_backup
    
    var localized: String {
        return self.rawValue.localized()
    }
    
    var localizedWithTable: String {
        return self.rawValue.localized(tableName: "Setting")
    }
}
