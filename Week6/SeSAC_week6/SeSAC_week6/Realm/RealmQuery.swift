//
//  RealmQuery.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/05.
//

import Foundation
import UIKit
import RealmSwift

// UIViewController 어디서든 쓸 수 있게끔 UIViewController extension
extension UIViewController {
    
    func searchQueryFromUserDiary(text: String) -> Results<UserDiary> {
        let localRealm = try! Realm()
        
        let search = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '\(text)' OR diaryContent CONATAINS[c] '\(text)'")
        
        return search
    }
    
    func getAllDiaryCountFromUserDiary() -> Int {
        let localRealm = try! Realm()
        
        return localRealm.objects(UserDiary.self).count
    }
}
