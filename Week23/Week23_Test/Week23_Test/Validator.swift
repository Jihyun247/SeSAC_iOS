//
//  Validator.swift
//  Week23_Test
//
//  Created by 김지현 on 2022/03/02.
//

import Foundation

final class Validator {
    
    func isValidID(id: String) -> Bool {

        return id.contains("@") && id.count >= 6
    }
    
    func isValidPassword(password: String) -> Bool {

        return password.count >= 6 && password.count <= 10
    }
    
    func isEqualPassword(password: String, check: String) -> Bool {

        return password == check
    }
}
