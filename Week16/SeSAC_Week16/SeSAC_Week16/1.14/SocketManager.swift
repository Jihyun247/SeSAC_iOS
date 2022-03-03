//
//  SocketManager.swift
//  SeSAC_Week16
//
//  Created by 김지현 on 2022/01/14.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject { // 왜 한다구 했더라 ?
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNWQzYmUzNDViZDllZDBjN2QzZCIsImlhdCI6MTY0MjEyMDY1OSwiZXhwIjoxNjQyMjA3MDU5fQ.m0vNMTl4yFh4u1v1qUqPQNra5eVpdtTlYCWHaBtj-7g"
    
    static let shared = SocketIOManager()
    
    // 서버와 메시지를 주고받기 위한 클래스
    var manager: SocketManager? // 소켓 연결/해제 하는 것 총괄 관리하는 소켓 매니저
    
    // 클라이언트 소켓
    var socket: SocketIOClient? // 중심 기능
    
    override init() {
        super.init()
        
        let url = URL(string: "http://test.monocoding.com:1233")!
        manager = SocketManager(socketURL: url, config: [
            .log(true),
            .compress,
            .extraHeaders(["auth": token])
        ])
        
        socket = manager?.defaultSocket // "/로 된 룸" 큰 통로 생성, 이 내에서 작은 방들이 만들어지는 것 (초기화 과정)
        
        // 연결해줘
        socket?.on(clientEvent: .connect, callback: { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        })
        
        // 연결된 상태에서 어떤 특정한 것을 처리할 때 (소켓 채팅 듣는 메서드, sesac이벤트로 날아온 데이터를 수신 후 처리)
        // 데이터 수신 -> 디코딩 -> 모델에 추가 -> 띄우기
        socket?.on("sesac") { dataArray, ack in
            print("SOCKET RECEIVED", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let createdAt = data["createdAt"] as! String
            
            print("CHECK", chat, name, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "name": name, "createdAt": createdAt])
        }
        
        
        // 연결 끊어줘
        socket?.on(clientEvent: .disconnect, callback: { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        })
    }
    
    func establishConnection() {
        socket?.connect()
    }
    
    func closeConnection() {
        socket?.disconnect()
    }
}
