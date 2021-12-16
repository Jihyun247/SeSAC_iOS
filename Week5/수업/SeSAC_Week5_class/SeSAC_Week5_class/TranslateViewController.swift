//
//  TranslateViewController.swift
//  SeSAC_Week5_class
//
//  Created by 김지현 on 2021/10/26.
//

import UIKit
import Network

import Alamofire
import SwiftyJSON

class TranslateViewController: UIViewController {
    
    
    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    
    // 서버 통신 할 때마다 텍스트 뿐만 아니라 많은 오브젝이 함께 바뀌어야 하는 경우가 많음 -> 이 때 didSet 활용 !
    var translateText: String = "" {
        didSet {
            targetTextView.text = translateText
        }
    }
    
    let networkMonitor = NWPathMonitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 네트워크 변경 감지 클래스를 통해서 사용자의 네트워크 상태가 변경될 때마다 실행
        networkMonitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Network Connected")
                
                if path.usesInterfaceType(.cellular) {
                    print("Cellular Status")
                } else if path.usesInterfaceType(.wifi) {
                    print("WIFI")
                } else {
                    print("Others")
                }
                
            } else {
                print("Network Disconnected")
            }
            
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
    }
    
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
        // textview의 text 타입은 옵셔널스트링 = nil이 될 확률 없음
        // 옵셔널 해제 방법 1. 강제해제 !
        //TranslatedAPIManager.shared.fetchTranslateData(text: sourceTextView.text!)
        // 2.
        guard let text = sourceTextView.text else { return }
        
        // 네트워크 부분 비동기 처리 해주는 것이 좋음 !!! (DispatchQueue 쓰는 것이 좋지만, 애초에 Alamorife가 비동기처리를 하기 때문에 ㄱㅊ)
        TranslatedAPIManager.shared.fetchTranslateData(text: text) { code, json in
            
            
            // 서버 통신 시 string 하나만 가져온다면 code와 json을 모두 가져오지 않고 그냥 manager.swift에서 통신 완료 후 string만
            // 매개변수로 가져오면 되지만, 더 많은 변수들을 가져오기 위해 탈출클로저를 통해 code와 json을 가져오고
            // 코드로 분기처리를 하고, 분기마다 json을 통해 원하는 정보를 가져온다
            switch code {
            case 200:
                print(json)
                self.translateText = json["message"]["result"]["translatedText"].stringValue
            case 400:
                print(json)
                self.translateText = json["errorMessage"].stringValue
            default:
                print("오류")
            }
            
            //self.targetTextView.text = json["message"]["result"]["translatedText"].stringValue
        }
    }
    
}
