//
//  MemoTableViewController.swift
//  SeSAC_03Week_1
//
//  Created by 김지현 on 2021/10/12.
//

import UIKit
import CloudKit

class MemoTableViewController: UITableViewController {
    
    // MARK: - 변수
    
//    var list = [Memo]() {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    var list = [Memo]() {
        didSet{
            saveData()
        }
    }
    
    // MARK: - IBOutlet
    
    // 테이블뷰 셀 아울렛들은 셀 파일에, 테이블뷰 외의 uiview라서 여기에
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    

    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        UITableView.automaticDimension //(셀에대한 처리 및 갱신 - 줄거리가 길때 화살표 생기게끔 아래화살표일땐 네줄만, 위화살표일땐 갱신해서 모두 보이게끔)
    }
    
    // MARK: - IBAction
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        // 배열에 텍스트뷰의 텍스트 값 추가 (예외처리 !!!)
        if let text = memoTextView.text {
            
            let segmentIndex = categorySegmentedControl.selectedSegmentIndex
            let segmentCategory = Category(rawValue: segmentIndex) ?? .others
            let memo = Memo(content: text, category: segmentCategory)
            
            list.append(memo)
            
        } else {
            print("값 없음")
        }
    }
    
    // MARK: - func
    
    // 유저디폴트 저장과, 테이블뷰 갱신
    func saveData() {
        var memo: [[String:Any]] = []
        
        for i in list {
            let data: [String:Any] = [
                "category": i.category.rawValue,
                "content": i.content
            ]
            memo.append(data)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(memo, forKey: "memoList")
        
        tableView.reloadData()
        
    }
    
    // 유저디폴트에서 값 가져오기
    func loadData() {
        let userDefaults = UserDefaults.standard
        
        // object는 타입이 any, as?를 통해 타입캐스팅 해야 함 (불러올 구조랑 이 구조랑 같아? 와 같은 뜻)
        if let data = userDefaults.object(forKey: "memoList") as? [[String:Any]] {
            var memo = [Memo]()
            
            for datum in data {
                guard let category = datum["category"] as? Int else {
                    // alert 띄워주기도 함
                    return }
                guard let content = datum["content"] as? String else { return }
                
                let enumCategory = Category(rawValue: category) ?? .others
                
                memo.append(Memo(content: content, category: enumCategory))
            }
            self.list = memo
        }
    }

    // MARK: - tableView func
    
    // 1. 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 섹션이 여러개일 때 섹션마다 셀의 개수를 정해줄 수 있다
        return section == 0 ? 2 : list.count
    }
    // 2. 셀의 디자인 및 데이터 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 재사용 메커니즘 확인
        print(#function)
        
        // 옵셔널 체이닝 Early Exit
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier) as? BoxOfficeTableViewCell else {
            // 없으면 빈 셀 반환
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "첫번째 섹션입니다 - \(indexPath)"
            cell.textLabel?.textColor = .brown
            cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        } else {

            let row = list[indexPath.row]
            
            cell.textLabel?.text = row.content
            cell.detailTextLabel?.text = row.category.description
            cell.textLabel?.textColor = .green
            cell.textLabel?.font = .italicSystemFont(ofSize: 13)
            
            switch row.category {
            case .business:
                cell.imageView?.image = UIImage(systemName: "building.2")
            case .personal:
                cell.imageView?.image = UIImage(systemName: "person")
            case .others:
                cell.imageView?.image = UIImage(systemName: "square.and.pencil")
            }
        }

        return cell
    }
    // 3. 셀의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 44 : 80
    }
    
    
    
    // 옵션. 섹션의 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 옵션. 섹션 타이틀
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // section title 있어도 되고 없어도 돼서 string?
        return "섹션 타이틀"
    }
    
    // 옵션. 셀을 클릭했을 때 기능
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀 선택 !!!")
    }
    
    // 옵션. 셀 편집 상태 관리 (셀 스와이프 ON/OFF 여부 : canEditRowAt)
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    
    // 옵션. 셀 스와이프 ON canMoveRowAt
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 && editingStyle == .delete {
            list.remove(at: indexPath.row)
        }
        
    }
    
}
