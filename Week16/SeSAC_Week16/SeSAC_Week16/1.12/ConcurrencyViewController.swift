//
//  ConcurrencyViewController.swift
//  SeSAC_Week16
//
//  Created by 김지현 on 2022/01/12.
//

import UIKit

class ConcurrencyViewController: UIViewController {
    
    let url1, url2, url3: URL?
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func basic(_ sender: UIButton) {
        print("hello world") // 1
        
        for i in 1...100 { // 2
            print(i, terminator: " ")
        }
        
        for i in 101...200 { // 3
            print(i, terminator: " ")
        }
        
        print("bye world") // 4
    }
    
    @IBAction func mainAsync(_ sender: UIButton) {
        print("hello world") // 1
        
        // async queue에 보내놓음. 근데 결국엔 원래 Main꺼라 다시 Main에 돌아옴 (async이기 때문에 보내놓은 다음 바로 다음 Task가 실행된다. 원 순서가 중요하지 않음)
        DispatchQueue.main.async { // 4
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }

        for i in 101...200 { // 2
            print(i, terminator: " ")
        }
        
        print("bye world") // 3
    }
    
    @IBAction func deadLock(_ sender: UIButton) {
        print("hello world")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }

        // Dead Lock에 빠져서 에러가 남, Main에서는 sync로 큐에 넘겨준 다음 기다리고 있는데, 넘겨준 task는 main에서 실행되어야 하기 때문. 따라서 Main에서는 sync를 사용하지 않는다.
        DispatchQueue.main.sync {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print("bye world")
    }
    
    @IBAction func globalSyncAsync(_ sender: UIButton) {
        print("hello world") // 1
        
        // global.sync - 메인스레드로 동작하는 거랑 다를게없음
        // 다른 스레드로 동기적으로 보내는 코드라도 실직적으로는 메인 스레드에서 일함. (니가하나 내가하나 똑같으니 걍 안보내고 내가한다)
        // global.async - 다 끝나고 해당 문장이 실행됨
        DispatchQueue.global().async { // 2
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        // 명확하게 무엇이 마지막인지 알 수 없음
        for i in 1...100 { // 값이 섞여 나옴
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 { // 3
            print(i, terminator: " ")
        }
        
        print("bye world") // 4
        
    }
    
    @IBAction func globalQueue(_ sender: UIButton) {
        
        let queue = DispatchQueue(label: "concurrentJihyun", qos: .userInteractive, attributes: .concurrent)
        
        // Quality of service - qos - 우선순위 설정 가능
        // utility - 프로그래스바 돌면서
        //
        DispatchQueue.global(qos: .background).async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        queue.async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("끝")
            self.view.backgroundColor = .lightGray
        }
    }
    
    @IBAction func urlsessionDispatchGroup(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
//        DispatchQueue.global().async(group: group) {
//            self.request(url: self.url1!) { image in
//                print("image1")
//            }
//        }
//
//        DispatchQueue.global().async(group: group) {
//            self.request(url: self.url2!) { image in
//                print("image1")
//            }
//        }
//
//        DispatchQueue.global().async(group: group) {
//            self.request(url: self.url3!) { image in
//                print("image1")
//            }
//        }
//
//        group.notify(queue: .main) {
//            print("끝")
//        }
        
        group.enter() // enter leave 개수 되도록 맞추기
        request(url: url1!) { image in
            print("image1")
            group.leave()
        }
        
        group.enter()
        request(url: url2!) { image in
            print("image2")
            group.leave()
        }
        
        group.enter()
        request(url: url3!) { image in
            print("image3")
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("끝")
        }
    }
    
    func request(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(UIImage(systemName: "star"))
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    @IBAction func asyncAwait(_ sender: UIButton) {
        
        Task {
            
            do {
                let request1 = try await newRequest(url: url1!)
                let request2 = try await newRequest(url: url2!)
                let request3 = try await newRequest(url: url3!)
                
                image1.image = request1
                image2.image = request2
                image3.image = request3
            } catch {
                print("error")
            }
        }
    }
    
    @IBAction func raceCondition(_ sender: UIButton ) {
        
        var nickname = "jh"
        let group = DispatchGroup()
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "asdf"
            print("First: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "qwerty"
            print("Second: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)")
        }
    }
    
    func newRequest(url: URL) async throws -> UIImage {
        
        //
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.statusCodeError
        }
        
        guard let image = UIImage(data: data) else {
            throw APIError.unsupportedImage
        }
        
        return image
    }
}

enum APIError: Error {
    case statusCodeError, unsupportedImage
}
