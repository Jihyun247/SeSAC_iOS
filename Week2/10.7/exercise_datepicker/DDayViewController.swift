//
//  DDayViewController.swift
//  exercise_datepicker
//
//  Created by 김지현 on 2021/10/07.
//

import UIKit

class DDayViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        print(datePicker.date)
        print(sender.date)
        
        // DateFormatter: 1. DateFormat 2. 한국
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        
        let value = format.string(from: sender.date)
        print(value)
        
        // 100일 뒤 : TimeInterval
        let after100Date = Date(timeInterval: 86400 * 100, since: sender.date)
        print(after100Date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
        datePicker.preferredDatePickerStyle = .inline
        }

    }
    
    
}
