//
//  Constants.swift
//  SeSAC_Week5_class
//
//  Created by 김지현 on 2021/10/27.
//

import Foundation

struct APIKey {
    static let NAVER_ID = "sKd1gAvfaou8JKuQX1O8"
    static let NAVER_SECRET = "7uVQRpbcGR"
    static let KAKAO = "KakaoAK 43ecf38a53ee927e6567f62995510315"
}

struct Endpoint {
    static let translatedURL = "https://openapi.naver.com/v1/papago/n2mt"
    static let visionURL = "https://dapi.kakao.com/v2/vision/face/detect"
    static let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=73d96d9e7714af877056008c9a26c56c"
}
