//
//  AsyncViewController.swift
//  SeSAC_Week5_class
//
//  Created by 김지현 on 2021/10/29.
//

struct A {
    var abc: String
}

class B {
    var abc = ""
}

import UIKit

class AsyncViewController: UIViewController {
    
    // weak unknown
    @IBOutlet var collctionLabel: [UILabel]!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    let url = "https://cdn.pixabay.com/photo/2019/08/01/12/36/illustration-4377408_1280.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. 어제 날짜 구하기
        let calendar = Calendar.current
        // 지금 날짜 기준으로 1일을 더한다. yesterday는 -1 하면 될듯
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())
        print(tomorrow)
        
        // 2. 이번주 월요일은 ? component let으로 선언하면 에러 생김 (struct 와 class 차이)
        var component = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday], from: Date())
        component.weekday = 2
        let mondayWeek = calendar.date(from: component)
        print(mondayWeek)
        
        for i in collctionLabel {
            i.backgroundColor = .blue
        }
        
        collctionLabel.forEach { $0.setBorderStyle() }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = ""
        
    }
    
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        DispatchQueue.global().async {
            if let url = URL(string: self.url), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                
                // UI는 메인쓰레드에서, 나머지 파일다운, url 처리 등은 다른 쓰레드에서
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
}
