//
//  ChatViewController.swift
//  SeSAC_Week16
//
//  Created by 김지현 on 2022/01/13.
//

import UIKit
import Alamofire

// MARK: - Chat
struct Chat: Codable {
    let id, text, userID, name: String
    let username, createdAt, updatedAt: String
    let v: Int
    let chatID: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text
        case userID = "userId"
        case name, username, createdAt, updatedAt
        case v = "__v"
        case chatID = "id"
    }
}

typealias Chats = [Chat]

class ChatViewController: UIViewController {
    
    let url = "http://test.monocoding.com:1233/chats"
    let name = "jh123"
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNWQzYmUzNDViZDllZDBjN2QzZCIsImlhdCI6MTY0MjEyMDY1OSwiZXhwIjoxNjQyMjA3MDU5fQ.m0vNMTl4yFh4u1v1qUqPQNra5eVpdtTlYCWHaBtj-7g"
    
    var list: Chats = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "yourCell")
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(nofitication:)), name: NSNotification.Name("getMessage"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "보내기", style: .plain, target: self, action: #selector(postChat))
        
        requestChats()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }
    
    @objc func getMessage(nofitication: NSNotification) {
        let chat = nofitication.userInfo?["chat"] as! String
        let name = nofitication.userInfo?["name"] as! String
        let createdAt = nofitication.userInfo?["createdAt"] as! String
        
        let value = Chat(id: "", text: chat, userID: "", name: name, username: "", createdAt: createdAt, updatedAt: "", v: 0, chatID: "")
        
        list.append(value)
        tableView.reloadData()
        // 필요한 시점에 밑으로 내리는 것이 더 편함
        self.tableView.scrollToRow(at: IndexPath(row: self.list.count-1, section: 0), at: .bottom, animated: false)
    }
    
    @objc func postChat() {
        postChat()
    
    func postChat() {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        let array = ["하나둘셋넷", "메롱메롱"]
        
        AF.request(url, method: .post, parameters: ["text": "\(array.randomElement()!)"], encoder: JSONParameterEncoder.default, headers: header).responseString { data in
            print("POST CHAT SUCCEED", data)
        }
        }
    }
    
    // DB (last chat time) : 나중에는 DB에 기록된 채팅의 마지막 시간을 서버에 요청. 새로운 데이터만 서버에서 받아오기!
    func requestChats() {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: Chats.self) { response in
            switch response.result {
                
            case .success(let value):
                self.list = value
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.list.count-1, section: 0), at: .bottom, animated: false)
                SocketIOManager.shared.establishConnection()
            case .failure(let error):
                print("Fail", error)
            }
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = list[indexPath.row]
        
        if data.name == name {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
            cell.backgroundColor = .systemYellow
            var content = cell.defaultContentConfiguration()
            content.text = "\(data.name)\n \(data.text)"
            content.image = UIImage(systemName: "star.fill")
            cell.contentConfiguration = content
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "yourCell")!
            cell.backgroundColor = .lightGray
            var content = cell.defaultContentConfiguration()
            content.text = "\(data.name)\n \(data.text)"
            content.image = UIImage(systemName: "star.fill")
            cell.contentConfiguration = content
            return cell
        }
        
        
    }
    
    
}
