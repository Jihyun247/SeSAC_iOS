//
//  RealmModel.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/02.
//

import Foundation
import RealmSwift

class UserDiary: Object {
    @Persisted var diaryTitle: String // 제목(필수)
    @Persisted var diaryContent: String? // 내용(옵션)
    @Persisted var writeDate = Date() // 작성 날짜(필수)
    @Persisted var regDate = Date() // 등록일(옵션)
    @Persisted var favorite: Bool // 즐겨찾기 기능(필수)
    
    // PK(필수): Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId

    convenience init(diaryTitle: String, diaryContent: String?, writeDate: Date, regDate: Date) {
        self.init()
        
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.writeDate = writeDate
        self.regDate = regDate
        self.favorite = false
    }
}
