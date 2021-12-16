//
//  ViewController.swift
//  SeSAC_Xib
//
//  Created by 김지현 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var presentButton: UIButton!
    
    
    // IBOutlet 말고도 코드로도 뷰 객체를 등록할 수 있다
    // (아울렛을 지정해주면 uiviewcontroller에서는 require init이 자동으로 호출된다)
    let redView = UIView()
    let greenView = UIView()
    let blueView = UIView()
    
    // 각 커스텀 뷰를 각각 바꾸는 방법
    @IBOutlet weak var favoriteBoxView: SquareBoxView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greenView.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        
        greenView.clipsToBounds = true
        greenView.layer.allowsGroupOpacity = true // 이거 속성 더 찾아보기
        redView.alpha = 0.5
        
        redView.frame = CGRect(x: 30, y: 30, width: 200, height: 200)
        greenView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        blueView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        blueView.backgroundColor = .blue
        
        favoriteBoxView.label.text = "즐겨찾기"
        favoriteBoxView.imageView.image = UIImage(systemName: "star")
    }
    
    
    @IBAction func presentButtonClicked(_ sender: UIButton) {
        present(DetailViewController(), animated: true, completion: nil)
    }
    

}

