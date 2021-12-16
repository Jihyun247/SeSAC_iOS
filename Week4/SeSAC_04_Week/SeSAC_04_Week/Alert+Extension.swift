//
//  Alert+Extension.swift
//  SeSAC_04_Week
//
//  Created by 김지현 on 2021/10/21.
//

import UIKit

extension UIViewController {
//    func showAlert() {
//        let alert = UIAlertController(title: "위치 권한 없음", message: "설정으로 이동해주세요", preferredStyle: .alert)
//
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//
//        let ok = UIAlertAction(title: "확인", style: .default) {_ in
//            print("확인 버튼 눌렀음")
//
//            guard let url = URL(string: UIApplication.openSettingsURLString) else {
//                return
//            }
//
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url) { success in
//                    print("잘 열렸다 \(success)")
//                }
//            }
//        }
//
//        alert.addAction(cancel)
//        alert.addAction(ok)
//
//        self.present(alert, animated: true) {
//            print("얼럿이 떴습니다.")
//        }
//    }
    
    func showAlert(title: String, message: String, okTitle: String, okAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        let ok = UIAlertAction(title: okTitle, style: .default) {_ in
            print("확인 버튼 눌렀음")
            
            // 클로저 안의 함수 -> 탈출시켜주어야 한다 ! 탈출클로저
            okAction()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: true) {
            print("얼럿이 떴습니다.")
        }
    }
}
