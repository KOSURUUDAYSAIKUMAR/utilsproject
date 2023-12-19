//
//  NameValidate.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 19/12/23.
//

import UIKit

class Validate: NSObject {
    
    func isValidFullName(_ fullName: String) -> Bool {
        let fullNameRegex = Regex.fullName
        if let regex = try? NSRegularExpression(pattern: fullNameRegex, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: fullName.utf16.count)
            return regex.firstMatch(in: fullName, options: [], range: range) != nil
        }
        return false
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = Regex.EmailRegex
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // Helper methods for password validation
    func hasUpperCase(_ text: String) -> Bool {
        return text.rangeOfCharacter(from: .uppercaseLetters) != nil
    }
    
    func hasNumber(_ text: String) -> Bool {
        return text.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    func hasSymbol(_ text: String) -> Bool {
        let symbolCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()")
        return text.rangeOfCharacter(from: symbolCharacterSet) != nil
    }
}

extension String {
    
}
