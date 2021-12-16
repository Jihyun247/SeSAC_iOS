//
//  CalendarViewController.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/05.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {

    
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var allCountLabel: UILabel!
    
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        tasks = localRealm.objects(UserDiary.self)
        print(tasks)
        
        let allCount = localRealm.objects(UserDiary.self).count
        allCountLabel.text = "총 \(allCount)개의 일기를 썼다"
        
        // realm 쿼리처럼 sorting
        let recent = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writeDate", ascending: false).first?.diaryTitle
        let old = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writeDate", ascending: true).first
        
        let full = localRealm.objects(UserDiary.self).filter("diaryContent != nil").count
        
        let favorite = localRealm.objects(UserDiary.self).filter("favorite = false")
        
        let search = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] '일기' OR diaryContent CONTAINS[c] '살아와'")
        
        // realm Usage Examples filter - data
        // 문자열 같은 경우 "assignee == 'ALI' AND isComplete == true"
        print(recent, old, full, favorite)
    }


}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        return "title"
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        return "subtitle"
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return UIImage(systemName: "star")
    }
    
    // Date format 시 시분초까지 모두 동일해야 함
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // 11/2 3개의 일기라면 3개를, 없다면 x, 1개는 1개
        
        
        return tasks.filter("writeDate == %@", date).count
    }
    
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
//        <#code#>
//    }
}
