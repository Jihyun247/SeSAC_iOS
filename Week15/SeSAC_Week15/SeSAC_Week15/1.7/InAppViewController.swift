//
//  InAppViewController.swift
//  SeSAC_Week15
//
//  Created by 김지현 on 2022/01/07.
//

import Foundation
import UIKit
import StoreKit
import SnapKit

class InAppViewController: UIViewController {
    
    // 1. 인앱 상품ID 정의
    var productIdentifiers: Set<String> = ["com.jihyeon.OOD_iOS.dumbbell100"]
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestProductData()
        
        view.addSubview(button)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
    }
    
    @objc func buttonClicked() {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
    }
    
    // 3-1. 인앱 상품 배열
    var productArray = Array<SKProduct>()
    var product: SKProduct? // 구매 할 상품
    
    // 2. productIdentifiers에 정의된 상품ID에 대한 정보 가져오기 및 사용자의 디바이스가 인앱결제가 가능한지 여부 확인
    func requestProductData() {
        if SKPaymentQueue.canMakePayments() { //결제를 할 수 있는 상태인가
            print("인앱 결제 가능")
            let request = SKProductsRequest(productIdentifiers: productIdentifiers)
            request.delegate = self
            request.start() // 인앱 상품 조회
        } else {
            print("In App Purchase Not Enabled")
        }
    }
    
    func receiptValidation(transaction: SKPaymentTransaction, productIdentifier: String) {
        
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        print(receiptString)
        // 거래 내역 (transaction)을 큐에서 제거
        SKPaymentQueue.default().finishTransaction(transaction)
    }
}

extension InAppViewController: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        let products = response.products
        
        if products.count > 0 {
            
            // 상품을 하나씩 조회
            for i in products {
                productArray.append(i)
                product = i // 옵션
                
                print("product: ", i)
            }
            
        } else {
            print("No Product Found")
        }
    }
    
    
}

// SKPaymentTransactionObserver: 구매 취소, 승인에 대한 성공 실패 판단 프로토콜
extension InAppViewController: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
                
            case .purchasing: // 구매 승인 이후에 영수증 검증
                
                print("Transaction Approved. \(transaction.payment.productIdentifier)")
                // 영수증 검증
                receiptValidation(transaction: transaction, productIdentifier: transaction.payment.productIdentifier)
                
            case .failed: // 실패 토스트, transaction
                
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                
            @unknown default:
                break
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("removedTransactions")
    }
}
