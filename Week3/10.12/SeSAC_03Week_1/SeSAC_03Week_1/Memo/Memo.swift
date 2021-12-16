//
//  Memo.swift
//  SeSAC_03Week_1
//
//  Created by 김지현 on 2021/10/14.
//

import Foundation

enum Category: Int {
    case business = 0, personal, others
    
    var description: String {
        switch self {
        case .business:
            return "업무"
        case .personal:
            return "개인"
        case .others:
            return "기타"
        }
    }
}


struct Memo {
    var content: String
    var category: Category // 0업무 1개인 2기타
}
