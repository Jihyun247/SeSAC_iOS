//
//  UISetting.swift
//  TrendMedia
//
//  Created by 김지현 on 2021/10/24.
//

import UIKit

// 구조체 ? 클래스 ? 무엇이 나을까
class UISetting {
    
    func labelSetting(_ label: UILabel, _ text: String, _ textSize: Int, _ textStyle: String, _ line: Int, _ color: UIColor = .black) {
        label.text = text
        label.textColor = color
        
        if textStyle == "system" {
            label.font = UIFont.systemFont(ofSize: CGFloat(textSize))
        } else if textStyle == "bold" {
            label.font = UIFont.boldSystemFont(ofSize: CGFloat(textSize))
        }
        
        label.numberOfLines = line
    }
    
    // clipsToBounds 안하면 이미지 radius가 적용이 안되고,, clipsToBounds 적용하면 그림자까지 잘린다
    func shadowAndRadius(_ view: UIView, _ shadowOpacity: Float, _ shadowColor: CGColor, _ shadowRadius: CGFloat, _ cornerRadius: CGFloat, _ clipsToBounds: Bool) {
        
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowColor = shadowColor
        //view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = shadowRadius
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = clipsToBounds
        
    }
}
