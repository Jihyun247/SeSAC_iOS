//
//  ViewController.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {
    
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 10),
        Array(repeating: "c", count: 15),
        Array(repeating: "d", count: 20),
        Array(repeating: "e", count: 10),
        Array(repeating: "f", count: 15),
        Array(repeating: "g", count: 10)
    ]
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var backupRestoreLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        title = "HOME"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        // tabbar
        self.tabBarController?.tabBar.backgroundColor = .systemGray6
        if let item = self.tabBarController?.tabBar.items {
            
            item[0].title = "HOME"
            item[1].title = "검색"
            item[2].title = "캘린더"
            item[3].title = "설정"
            
            item[0].image = UIImage(systemName: "house")
            item[1].image = UIImage(systemName: "magnifyingglass")
            item[2].image = UIImage(systemName: "calendar")
            item[3].image = UIImage(systemName: "person.circle")
 
        }
        

        //welcomeLabel.text = "HELLO WORLD! 반가워요"
        //welcomeLabel.text = NSLocalizedString("welcome_text", comment: "")
        //welcomeLabel.text = "welcome_text".localized
        welcomeLabel.text = LocalizableStrings.welcome_text.localized
        
        // 일반적 폰트 크기 : 11-20
        //welcomeLabel.font = UIFont(name: "S-CoreDream-9Black", size: 14)
        welcomeLabel.font = UIFont().mainBlack
        
        //backupRestoreLabel.text = NSLocalizedString("data_backup", tableName: "Setting", bundle: .main, value: "", comment: "")
        backupRestoreLabel.text = LocalizableStrings.data_backup.localizedWithTable
        
        // tableview
        tableView.delegate = self
        tableView.dataSource = self
        
    
    }
    
    @objc func addButtonClicked() {
        let sb = UIStoryboard(name: "Content", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        //vc.modalPresentationStyle = .fullScreen
        //present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.data = array[indexPath.row]
        cell.categoryLabel.text = "\(array[indexPath.row])"
        cell.categoryLabel.backgroundColor = .yellow
        cell.collectionView.tag = indexPath.row
        cell.collectionView.isPagingEnabled = true
        cell.collectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
}


