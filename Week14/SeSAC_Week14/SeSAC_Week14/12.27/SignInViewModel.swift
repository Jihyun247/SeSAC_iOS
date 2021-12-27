//
//  SignInViewModel.swift
//  SeSAC_Week14
//
//  Created by 김지현 on 2021/12/27.
//

import UIKit

// MVVM

class SignInViewModel {
    
    var username: Observable<String> = Observable("고래밥")
    var password: Observable<String> = Observable("")
    
    func postUserLogin(completion: @escaping () -> Void) {
        
        APIService.login(identifier: username.value, password: password.value) { userData, err in
            
            guard let userData = userData else {
                return
            }
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "name")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()

        }
    }
}
