//
//  TranslatedAPIManager.swift
//  SeSAC_Week5_class
//
//  Created by 김지현 on 2021/10/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslatedAPIManager {
    
    static let shared = TranslatedAPIManager()
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchTranslateData(text: String, result: @escaping CompletionHandler) {
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.NAVER_ID,
            "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        let parameters = [
            "source": "ko",
            "target": "en",
            "text": text
        ]
        
        AF.request(Endpoint.translatedURL, method: .post, parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                
                result(code, json)
                
            case .failure(let error):
                print(error)
                
                
            }
                
        }
    }
}
