//
//  AddViewController.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/02.
//

import UIKit
import RealmSwift
import SwiftUI
import PhotosUI

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var imageMenuButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    
    let localRealm = try! Realm()
    let imagePicker = UIImagePickerController()
    var configuration = PHPickerConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()

        // navigation item
        title = "일기 작성"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        // UI Setting
        titleTextField.backgroundColor = .lightGray
        titleTextField.placeholder = "제목을 입력해주세요"
        titleTextField.textAlignment = .center
        contentTextView.backgroundColor = .lightGray
        contentTextView.text = "일기 내용"
        contentImageView.contentMode = .scaleAspectFill
        contentImageView.image = UIImage(named: "default")
        
        
        // PHPickerViewController
        configuration.selectionLimit = 1 // 선택 최대 asset수 - default는 1, unlimit은 0
        //configuration.filter = .any(of: [.images, .livePhotos])
        configuration.filter = .images
        imagePicker.delegate = self
        
        // UIMenu 버튼
        let camera = UIAction(title: "카메라 열기", image: UIImage(systemName: "camera")) { _ in
            self.openCamera()
            print("카메라 열기")
        }
        let gallery = UIAction(title: "갤러리에서 가져오기", image: UIImage(systemName: "photo.on.rectangle")) { _ in
            self.openLibrary()
            print("이미지 선택 !")
        }
        let defaultImage = UIAction(title: "기본 이미지 선택", image: UIImage(systemName: "person"), attributes: .destructive) { _ in
            self.contentImageView.image = UIImage(named: "default")
        }
        
        imageMenuButton.menu = UIMenu(children: [camera, gallery, defaultImage])
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    
    @IBAction func dateButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "날짜 선택", message: "날짜를 선택해주세요", preferredStyle: .alert)
        
        // Alert Customizing
        // DatePickerViewController() 코드를 가져온 것이지 스토리보드와는 상관이 없다
        // 따라서 스토리보드 씬 + 클래스 -> 화면 전환 코드와 같이 구현해주어야 한다
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController else {
            print("DatePickerViewController에 오류가 있음")
            return
        }
        contentView.view.backgroundColor = .systemGray6
        //contentView.preferredContentSize = CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
        contentView.preferredContentSize.height = 200
        alert.setValue(contentView, forKey: "contentViewController")
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            // 확인버튼을 눌렀을 때 버튼의 타이틀 변경
            
            // dateformatter 통해서 한국 시간으로 변경 필요
            // format은 클래스이기 때문에 let으로 선언해도 클래스 내의 프로퍼티 변경 가능
            let format = DateFormatter()
            format.dateFormat = "yyyy년 MM월 dd일"
            let value = format.string(from: contentView.datePicker.date)
            
            self.dateButton.setTitle(value, for: .normal)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func cancelButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonClicked() {
        
//        let format = DateFormatter()
//        format.dateFormat = "yyyy년 MM월 dd일"
        
        guard let date = dateButton.currentTitle, let value = DateFormatter.customFormat.date(from: date) else {
            return
        }
        
        let task = UserDiary(diaryTitle: titleTextField.text!, diaryContent: contentTextView.text!, writeDate: value, regDate: Date())
        try! localRealm.write {
            localRealm.add(task)
            saveImageToDocumentDirectory(imageName: "\(task._id).jpg", image: contentImageView.image!)
        }
    }
    
    // 11/3 이미지 저장
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        // 1. 이미지 저장할 경로 설정 : 도큐먼트 폴더, FileManager
        // FileManager.default -> 싱클톤패턴
        // Desktop/jihyun/ios/folder
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 (Desktop/jihyun/ios/folder/222.png)
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축 jpegData , pngData 압축 실패 시 early exit
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 4. 이미지 저장: 동ㅇ릴한 경로에 이미지를 저장하게 될 경우
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            // 4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지 삭제 실패")
            }
        }
        
        // 5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
        } catch {
            print("이미지 저장 못함")
        }
    }
}

extension AddViewController: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true, completion: nil)
        
        // PHPickerResult -> 사진 라이브러리에서 선택한 asset의 타입
        // NSItemProvider -> 끌/놓 또는 복/붙 프로세스 간 데이터/파일을 전달하는 item provider
        
        // Get the first item provider from the results
        let itemProvider = results.first?.itemProvider
        
        // Access the UIImage representation for the result
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            // 로드 가능한 타입인지 확인 후 가져옴
            
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                
                if let image = image {
                    // 클로저 매개변수 전자가 타입이 uiimage가 아니라 NSItemProviderReading 타입이라 타입 캐스팅 해주어야 함
                    DispatchQueue.main.async {
                        self.contentImageView.image = image as? UIImage
                    }
                }
            }
        }
    }
    
    func openCamera() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openLibrary() {
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}
