//
//  SearchAPIManager.swift
//  TrendMedia
//
//  Created by 김지현 on 2021/11/02.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchAPIManager {
    
    static let shared = SearchAPIManager()
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchSearchData(text: String, startPage: Int, totalCount: Int, result: @escaping CompletionHandler) {
        
        // 쿼리에 문제가 없을 때 실행해라 !
        if let text = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(text)&display=15&start=\(startPage)"
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": APIKey.NAVER_ID,
                "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    let code = response.response?.statusCode ?? 500
                    
                    result(code,json)
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
}
