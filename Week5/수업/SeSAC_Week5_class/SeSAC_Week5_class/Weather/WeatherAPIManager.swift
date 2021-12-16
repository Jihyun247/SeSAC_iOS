//
//  WeatherAPIManager.swift
//  SeSAC_Week5_class
//
//  Created by 김지현 on 2021/10/27.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    static let shared = WeatherAPIManager()
    
    func fetchWeatherData(result: @escaping CompletionHandler) {
        
        AF.request(Endpoint.weatherURL, method: .get).validate(statusCode: 200...500).responseJSON { response in
            
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
