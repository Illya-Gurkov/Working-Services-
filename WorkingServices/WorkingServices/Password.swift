//
//  Password.swift
//  WorkingServices
//
//  Created by Illya Gurkov on 4.10.22.
//

import Foundation
import UIKit
class ValidPassword {
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~']{8,}$")
        return passwordTest.evaluate(with: password)
    }
}

