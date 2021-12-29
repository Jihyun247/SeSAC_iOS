//
//  APIService.swift
//  SeSAC_Week14
//
//  Created by 김지현 on 2021/12/27.
//

import Foundation

enum APIError: Error {
    case invalid
    case noData
    case failed
    case invalidData
    case invalidResponse
}

class APIService { // 무연결성, 상태가 없는 것
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: Endpoint.login.url)
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    
    }
    
    static func lotto(_ number: Int, completion: @escaping (Lotto?, APIError?) -> Void) {
        
        let url = URL(string: "http://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let lottoData = try decoder.decode(Lotto.self, from: data)
                    completion(lottoData, nil)
                } catch {
                    
                }
            }
        }.resume()
    }
    
    static func person(_ text: String, page: Int, completion: @escaping (Person?, APIError?) -> Void) {
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let key = "15d1aaf499785fd09e6a137540c34c82"
        let language = "ko-KR"
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: language)
        ]
        
//        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=12187a8934be61b26128352c8596137c&language=en-US&query=%ED%98%84%EB%B9%88&page=1&include_adult=false&region=ko-KR")!
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in

            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let personData = try decoder.decode(Person.self, from: data)
                    completion(personData, nil)
                } catch {
                    
                }
            }
        }.resume()
    }
}
