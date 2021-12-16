//
//  DatePickerViewController.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.preferredDatePickerStyle = .wheels
    }
}
