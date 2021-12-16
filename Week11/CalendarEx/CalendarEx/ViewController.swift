//
//  ViewController.swift
//  CalendarEx
//
//  Created by 김지현 on 2021/12/10.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    lazy var today: Date = {
        return Date()
    }()
    
    @IBOutlet weak var calendar: FSCalendar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.scrollDirection = .horizontal
        calendar.locale = Locale(identifier: "ko")
        calendar.today = nil
        calendar.scope = .week
        calendar.select(self.today)
    }
}
