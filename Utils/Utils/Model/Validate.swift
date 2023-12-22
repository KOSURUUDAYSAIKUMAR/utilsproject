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
    
    // MARK: - Age
    func ageCount(text: String) -> Bool {
        return text.count == 2
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
    
    // MARK: - Mobile number validate
    func numberValidation(text: String) -> Bool {
        return text.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    func mobileNumberCount(text: String) -> Bool {
        return text.count >= 10
    }
    func isValidMobileNumber(text: String) -> Bool {
        let mobileNumberRegex = Regex.mobileNumber
        let predicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return predicate.evaluate(with: text)
    }
    func numberAllowedCharacteristics(text: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: Regex.numbers)
        let characterSet = CharacterSet(charactersIn: text)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    // MARK: - OTP
    func otpTextCount(text: String) -> Bool {
        return text.count == 4
    }
    
    // MARK: - Pin Code
    func isValidPIN(text: String) -> Bool {
        let pinRegex = Regex.validPin
        let predicate = NSPredicate(format: "SELF MATCHES %@", pinRegex)
        let isSixDigits = predicate.evaluate(with: text)
        let invalidPrefixes = ["15","29", "35", "54", "55", "65", "66"]
        let startsWithInvalidPrefix = invalidPrefixes.contains { text.hasPrefix($0) }
        return isSixDigits && !startsWithInvalidPrefix
    }
    
    func pinCodeCount(text:String) -> Bool {
        return text.count == 6
    }
    
    func pinCodeAllowedText(text: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: Regex.numbers)
        let characterSet = CharacterSet(charactersIn: text)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    // MARK: - Device ID.
    func getDeviceID() -> String {
        if let uuid = UIDevice.current.identifierForVendor {
            return uuid.uuidString
        }
        return ""
    }
    
    // MARK: - Drop Down text Static
    func isValidateDropDown(text: String, compareText: String) -> Bool {
        return text == compareText
    }
    
    // MARK: - Text View editable
    func textViewTextCount(text: String) -> Bool {
        return text.count >= 100
    }
    
    func textviewEditable(text: String, range: NSRange) {
        let currentText = text as NSString
        let newText = currentText.replacingCharacters(in: range, with: text)
        let _ = textViewTextCount(text: newText)
        textViewCalculateSpaces(newText: newText)
    }
    
    func textViewCalculateSpaces(newText: String) {
        let totalSpaces = newText.components(separatedBy: " ").count - 1
        let totalLetters = newText.components(separatedBy: CharacterSet.letters.inverted).joined().count
        let totalNumbers = newText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined().count
        print("Total Spaces: \(totalSpaces)")
        print("Total Letters: \(totalLetters)")
        print("Total Numbers: \(totalNumbers)")
    }
}

extension String {
    
}
