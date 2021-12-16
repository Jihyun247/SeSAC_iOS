//
//  VisionViewController.swift
//  SeSAC_Week5_class
//
//  Created by 김지현 on 2021/10/27.
//

import UIKit
import Alamofire
import SwiftyJSON
import JGProgressHUD

/*
 카메라: 시뮬레이터 테스트 불가능 -> 런타임 오류 발생
 - ImagePickerViewController -> PHPickerViewController (iOS14+)
 - iOS14+: 선택 접근 권한 + UI
 */

class VisionViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    // 사용할 프로그레스를 인스턴스화 시켜둔다
    // 언제 show, hide 할지 ! (show hide 각각 두개의 메서드 내에서 인스턴스를 만들면 다른 객체로 인식되니까)
    let progress = JGProgressHUD()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true // 크기 (확대축소) 변경 기능 추가
        imagePicker.delegate = self

    }
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        // in -> 어떤 UIView에서 띄워줄지, afterDelay -> 몇 초 뒤에 띄워줄지
        progress.show(in: view, animated: true)
        VisionAPIManager.shared.fetchFaceData(image: postImageView.image!) { code, json in
            print(json)
            // 서버 통신 끝나고 보여줄 내용이 모두 뜬 다음 dismiss
            self.progress.dismiss(animated: true)
        }
    }
}

extension VisionViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        // 사진을 읽는 것은 권한 허락 안받음 (photolibrary)
        // 카메라는 권한 허락 받음
        
        // 1. 선택한 사진 가져오기
        // allowEditing false > editedImage nil
        // allowEditing true > editingImage가 생기지만, originalImage를 가져오라고 코딩하면 편집한 것 소용x
        
        // allowEditing true로 했을 때
//        if let value = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            // 2. 로직 : 이미지뷰에 선택한 사진 보여주기
//            postImageView.image = value
//        }
        
        if let value = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 2. 로직 : 이미지뷰에 선택한 사진 보여주기
            postImageView.image = value
        }
        
        // 3. picker dismiss
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
}
