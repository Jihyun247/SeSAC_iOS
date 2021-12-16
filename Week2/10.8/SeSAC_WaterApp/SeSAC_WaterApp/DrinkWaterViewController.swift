//
//  DrinkWaterViewController.swift
//  SeSAC_WaterApp
//
//  Created by 김지현 on 2021/10/08.
//

import UIKit

extension UIColor {
    static let myGreenColor = UIColor(red: 86/255, green: 159/255, blue: 124/255, alpha: 1)
}

class DrinkWaterViewController: UIViewController {
    
    
    // MARK: 변수
    
    var nickname: String = ""
    var height = 0
    var weight = 0
    var goalWaterAmount: Double = 0
    var curWaterAmount: Double = 0
    var curWaterPercent = 0
    
    // MARK: IBOutlet
    
    @IBOutlet var praiseLabel: UILabel!
    @IBOutlet var curWaterAmountLabel: UILabel!
    @IBOutlet var curWaterPercentLabel: UILabel!
    @IBOutlet var cactusImageView: UIImageView!
    @IBOutlet var waterAmountTextField: UITextField!
    @IBOutlet var mlLabel: UILabel!
    @IBOutlet var recommendWaterAmountLabel: UILabel!
    @IBOutlet var drinkWaterButton: UIButton!
    

    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetting()
        navigationBarSetting()
        labelSetting(praiseLabel, "잘하셨어요!\n오늘 마신 양은", 25, "system", 2)
        textFieldSetting(waterAmountTextField)
        labelSetting(mlLabel, "ml", 25, "system", 0)
        buttonSetting(drinkWaterButton, "물마시기")
        
        print("drinkwaterVC viewdidload")
    }
    
    // MARK: viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        
        nickname = UserDefaults.standard.string(forKey: "nickname") ?? "이름"
        height = UserDefaults.standard.integer(forKey: "height")
        weight = UserDefaults.standard.integer(forKey: "weight")
        curWaterAmount = UserDefaults.standard.double(forKey: "currentWater")
        
        goalWaterAmountUpdate()
        waterAmountUpdate()

        labelSetting(recommendWaterAmountLabel, "\(nickname)님의 하루 물 권장 섭취량은 \(Double(goalWaterAmount/1000))L 입니다.", 15, "system", 0)
        cactusImageSetting(cactusImageView, curWaterPercent)
        
        print("drinkwaterVC viewwillappear")
    }
    
    // MARK: IBAction
    
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func resetButtonClicked(_ sender: UIBarButtonItem) {
        curWaterAmount = 0
        curWaterPercent = 0
        UserDefaults.standard.set(curWaterAmount, forKey: "currentWater")
        waterAmountUpdate()
        cactusImageSetting(cactusImageView, curWaterPercent)
    }
    
    @IBAction func drinkButtonClicked(_ sender: UIButton) {
        let waterAmount: String = waterAmountTextField.text ?? "0"
        
        curWaterAmount += Double(waterAmount)!
        if goalWaterAmount != 0 {
            curWaterPercent = Int(curWaterAmount/goalWaterAmount * 100)
            cactusImageSetting(cactusImageView, curWaterPercent)
            UserDefaults.standard.set(curWaterAmount, forKey: "currentWater")
            waterAmountUpdate()
        } else {
            let alert = UIAlertController(title: "알림", message: "프로필을 설정해주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: UISetting
    
    func viewSetting() {
        view.backgroundColor = .myGreenColor
    }
    
    func navigationBarSetting() {
        navigationItem.title = "물 마시기"
        navigationController?.navigationBar.tintColor = .white
    }
    
    func labelSetting(_ label: UILabel, _ text: String, _ textSize: Int, _ textStyle: String, _ line: Int, _ color: String = "white") {
        label.text = text
        if color == "red" {
            label.textColor = .red
        } else if color == "white" {
            label.textColor = .white
        }
        if textStyle == "system" {
            label.font = UIFont.systemFont(ofSize: CGFloat(textSize))
        } else if textStyle == "bold" {
            label.font = UIFont.boldSystemFont(ofSize: CGFloat(textSize))
        }
        label.numberOfLines = line
    }
    
    func waterAmountUpdate() {
        if goalWaterAmount < curWaterAmount {
            labelSetting(curWaterAmountLabel, "\(Int(curWaterAmount))ml", 35, "bold", 0, "red")
        } else {
            labelSetting(curWaterAmountLabel, "\(Int(curWaterAmount))ml", 35, "bold", 0)
        }
        labelSetting(curWaterPercentLabel, "목표의 \(Int(curWaterPercent))%", 20, "system", 0)
    }
    
    func textFieldSetting(_ tfield: UITextField) {
        tfield.placeholder = "0"
        tfield.textColor = .white
        tfield.textAlignment = .right
        tfield.font = UIFont.systemFont(ofSize: 25)
        tfield.backgroundColor = .clear
        tfield.keyboardType = .numberPad
    }
    
    func buttonSetting(_ btn: UIButton, _ t: String) {
        btn.setTitle(t, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
    }
    
    func cactusImageSetting(_ cactus: UIImageView, _ percent: Int) {
        if curWaterPercent >= 0 && curWaterPercent <= 10 {
            cactus.image = UIImage(named: "1-1")
        } else if curWaterPercent > 10 && curWaterPercent <= 20 {
            cactus.image = UIImage(named: "1-2")
        } else if curWaterPercent > 20 && curWaterPercent <= 30 {
            cactus.image = UIImage(named: "1-3")
        } else if curWaterPercent > 30 && curWaterPercent <= 40 {
            cactus.image = UIImage(named: "1-4")
        } else if curWaterPercent > 40 && curWaterPercent <= 50 {
            cactus.image = UIImage(named: "1-5")
        } else if curWaterPercent > 50 && curWaterPercent <= 60 {
            cactus.image = UIImage(named: "1-6")
        } else if curWaterPercent > 60 && curWaterPercent <= 70 {
            cactus.image = UIImage(named: "1-7")
        } else if curWaterPercent > 70 && curWaterPercent <= 80 {
            cactus.image = UIImage(named: "1-8")
        } else {
            cactus.image = UIImage(named: "1-9")
        }
    }
    
    func goalWaterAmountUpdate() {
        goalWaterAmount = Double((height + weight) * 10)
    }
    
    
    
}
