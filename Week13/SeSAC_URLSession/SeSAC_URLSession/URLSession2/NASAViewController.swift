//
//  NASAViewController.swift
//  SeSAC_URLSession
//
//  Created by 김지현 on 2021/12/22.
//

import UIKit

class NASAViewController: BaseViewController {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    var session: URLSession!
    
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0)
            label.text = "\(result * 100)/100"
        }
    }
    var total: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 nil이라 append 안됐음
        buffer = Data()
        
        configure()
        setupConstraints()
        request()
    }
    
    // 화면 사라질 때 세션 정리
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //session.invalidateAndCancel() // 리소스 그냥 다 정리 됨. 실행중인 테스크가 있더라도 중단
        session.finishTasksAndInvalidate() // 실행중인 테스크 모두 끝내고 중단
    }
    
    override func configure() {
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
    }
    
    override func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(label)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
    }
    
    func request() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2112/WinterSolsticeMW_Seip_1079.jpg")!
        print("request start")
        // 클로저 말고 sessiondelegate 쓸 경우 shared x
        //URLSession.shared.dataTask(with: url).resume()
        //URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: url).resume()
        
//        let configuration = URLSessionConfiguration.default
//        configuration.allowsCellularAccess = false
//        URLSession(configuration: configuration).dataTask(with: url).resume()
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session?.dataTask(with: url).resume()
    }
}

extension NASAViewController: URLSessionDataDelegate {

    // 서버에서 최초로 응답 받은 경우 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            total =  Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            return .allow
        } else {
            return .cancel
        }
    }
    
    // 서버에서 데이터를 받을 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // print(data)
        buffer?.append(data)
    }
    
    // 응답 완료 되었을 때
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print(error)
        } else {
            print("success") // completionhandler

            // buffer에 Data 가 모두 채워졌을 때, 이미지로 변환
            guard let buffer = buffer else {
                print("buffer error")
                return
            }

            let image = UIImage(data: buffer)
            imageView.image = image
        }
    }
}
