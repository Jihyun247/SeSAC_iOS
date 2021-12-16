//
//  VisionAPIManager.swift
//  SeSAC_Week5_class
//
//  Created by 김지현 on 2021/10/27.
//

import UIKit
import Alamofire
import SwiftyJSON
import UIKit

class VisionAPIManager {
    
    static let shared = VisionAPIManager()
    
    
    func fetchFaceData(image: UIImage, result: @escaping (Int, JSON) -> ()) {
        
        // Content-Type을 생략해도 에러가 안나는 이유: 라이브러리에서 멀티파트 폼 내에서 헤더가 내장되어 있기 때문이다.
        let header: HTTPHeaders = [
            "Authorization": APIKey.KAKAO,
            "Content-Type": "multipart/form-data"
        ]
        
        // UIImage를 바이너리 타입으로 변환 - pngData(), jpegData()
        guard let imageData = image.pngData() else {return}
        
        AF.upload(multipartFormData: { multipartFormData in
            //multipartFormData.append(imageData, withName: "image")
            multipartFormData.append(imageData, withName: "image", fileName: "image")
        }, to: Endpoint.visionURL, headers: header)
            .validate(statusCode: 200...500).responseJSON { response in
            
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
