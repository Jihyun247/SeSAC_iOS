//
//  SearchViewController.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/02.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: SearchTableViewCell.identifier)

        title = "검색"
        tableView.delegate = self
        tableView.dataSource = self
        
        tasks = localRealm.objects(UserDiary.self)
        //tasks = localRealm.objects(UserDiary.self).filter("favorite == true")
        print(localRealm.configuration.fileURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // 11/3
    // 도큐먼트 폴더 경로 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        // 1. 이미지 저장할 경로 설정 : 도큐먼트 폴더, FileManager
        // FileManager.default -> 싱클톤패턴
        // Desktop/jihyun/ios/folder
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 (Desktop/jihyun/ios/folder/222.png)
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
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
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        // cell 파일에서 셀 데이터 구현
        let row = tasks[indexPath.row]
        cell.configureCell(row: row)
        
        cell.img.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.layer.bounds.height / 6
    }
    
    // 원래는 화면전환 + 값 전달 후 새로운 화면에서 수정이 적합
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskToUpdate = tasks[indexPath.row]
        
        // 1. 수정 - 레코드에 대한 값 수정
//        try! localRealm.write {
//            taskToUpdate.diaryTitle = "새롭게 수정"
//            taskToUpdate.diaryContent = "어쩌구 저쩌구"
//            tableView.reloadData()
//        }
        
        // 2. 일괄 수정
//        try! localRealm.write {
//            tasks.setValue(Date(), forKey: "writeDate")
//            tasks.setValue("타이틀 일괄 수정", forKey: "diaryTitle")
//            tableView.reloadData()
//        }
        
        // 3. 수정: pk 기주으로 수정할 때 사용 (권장x)
//        try! localRealm.write {
//            let update = UserDiary(value: [ "_id" : taskToUpdate._id, "diaryTitle": "얘만 바꾸고 싶어"])
//            localRealm.add(update, update: .modified)
//            tableView.reloadData()
//        }
        
        // 4.
        try! localRealm.write {
            localRealm.create(UserDiary.self, value: [ "_id" : taskToUpdate._id, "diaryTitle": "얘만 바꾸고 싶어"], update: .modified)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        try! localRealm.write {
            deleteImageFromDocumentDirectory(imageName: "\(tasks[indexPath.row]._id).jpg")
            localRealm.delete(tasks[indexPath.row])
            tableView.reloadData()
        }
    }
    
    
}
