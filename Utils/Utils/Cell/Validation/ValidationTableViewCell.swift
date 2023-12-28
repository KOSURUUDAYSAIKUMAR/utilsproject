//
//  ValidationTableViewCell.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 19/12/23.
//

import UIKit

class ValidationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTextField: CustomTextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var otpTextField: UITextField!
    
    @IBOutlet weak var pinCodeTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    @IBOutlet weak var confirmPasswordTextField: PasswordTextField!
    @IBOutlet weak var dropDownTextField: UITextField!
    
    @IBOutlet weak var dropDown: UIView!
    @IBOutlet weak var submitView: UIView!
    var validate = Validate()
    var delegate: BaseVCProtocol?
    let centeredDropDown = DropDown()
 
    lazy var dropDowns: [DropDown] = {
        return [centeredDropDown]
    }()
    
    @IBAction func dropDown(_ sender: Any) {
        if let confirmText = confirmPasswordTextField.textField.text, let passwordText = passwordTextField.textField.text, confirmText == passwordText {
            confirmPasswordTextField.textField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
        } else if let age = confirmPasswordTextField.textField.text, age.count <= 0 {
            print("Empty details")
            confirmPasswordTextField.textField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
        } else {
            confirmPasswordTextField.textField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
            delegate?.showAlert?(msg: "Confirm password doesnot match")
        }
        centeredDropDown.show()
        dropDownHandler()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        submitView.addBorderAndColor(color: UIColor.systemBlue, width: 1, corner_radius: 5, clipsToBounds: true)
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
        // Initialization code
    }

    func setUI(with index: Int) {
        passwordTextField.textField.isSecureTextEntry = true
        confirmPasswordTextField.textField.isSecureTextEntry = true
        nameTextField.textField.delegate = self
        nameTextField.textField.backgroundColor = .white
        passwordTextField.textField.backgroundColor = .white
        confirmPasswordTextField.textField.backgroundColor = .white
        nameTextField.placeholderText = "Name"
        passwordTextField.placeholderText = "Password"
        confirmPasswordTextField.placeholderText = "Confirm Password"
        ageTextField.delegate = self
        mailTextField.delegate = self
        mobileTextField.delegate = self
        otpTextField.delegate = self
        passwordTextField.textField.delegate = self
        confirmPasswordTextField.textField.delegate = self
        pinCodeTextField.delegate = self
        ageTextField.keyboardType = .numberPad
      //  textLabel?.text = self.currentList[indexPath.section].dataList[indexPath.row]
    }
    
    func dropDownHandler() {
        centeredDropDown.anchorView = dropDown
        centeredDropDown.dataSource = [
            "Junior Developer",
            "Senior Developer",
            "Team Lead",
            "Project Manger",
            "    "
        ]
        centeredDropDown.selectionAction = { [self] (index, item) in
            print("Item ", item)
            let trimmedString = item.trimmed()
            if !trimmedString.isEmpty {
                dropDownTextField.text = item
                dropDownTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                dropDownTextField.text = "Field can't be empty"
                dropDownTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                print("The string is empty or contains only whitespace characters.")
            }
            centeredDropDown.hide()
        }
    }
    
    @IBAction func submitHandler(_ sender: Any) {
        if areAllTextFieldsEmpty() {
            delegate?.showAlert?(msg: "All textfields are required")
        } else if dropDownTextFieldsEmpty() {
            delegate?.showAlert?(msg: "Drop down text should not be empty")
            dropDownTextField.text = "Field can't be empty"
            dropDownTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
        } else {
            delegate?.showAlert?(msg: "Submit Successfully")
        }
    }
    
    func areAllTextFieldsEmpty() -> Bool {
        // Check if all text fields are empty
        return nameTextField.textField.text?.isEmpty ?? true &&
        ageTextField.text?.isEmpty ?? true &&
        mailTextField.text?.isEmpty ?? true &&
        mobileTextField.text?.isEmpty ?? true &&
        otpTextField.text?.isEmpty ?? true &&
        passwordTextField.textField.text?.isEmpty ?? true &&
        confirmPasswordTextField.textField.text?.isEmpty ?? true &&
        dropDownTextField.text?.isEmpty ?? true &&
        pinCodeTextField.text?.isEmpty ?? true
    }
    
    func dropDownTextFieldsEmpty() -> Bool {
        if let text = dropDownTextField.text {
            if text.isEmpty {
                return true
            }
            return validate.isValidateDropDown(text: dropDownTextField.text ?? "", compareText: Regex.emptyFields)
        }
        return false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

extension ValidationTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField.textField:
            if validate.isValidFullName(nameTextField.textField.text ?? "") {
                nameTextField.textField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = nameTextField.textField.text, age.count <= 0 {
                print("Empty details")
                nameTextField.textField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                nameTextField.textField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Invalid name")
            }
        case ageTextField:
            if let age = ageTextField.text?.trimmed(), validate.ageCount(text: age), validate.numberValidation(text: age) {
                ageTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = ageTextField.text, age.count <= 0 {
                print("Empty details")
                ageTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                ageTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Invalid age")
            }
        case mailTextField:
            if let text = mailTextField.text, validate.isValidEmail(text) {
                mailTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = mailTextField.text, age.count <= 0 {
                print("Empty details")
                mailTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                delegate?.showAlert?(msg: "Invalid mail")
                mailTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
            }
        case mobileTextField:
            if let text = mobileTextField.text, validate.numberValidation(text: text), validate.mobileNumberCount(text: text), validate.isValidMobileNumber(text: text) {
                mobileTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = mobileTextField.text, age.count <= 0 {
                mobileTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                mobileTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Invalid Mobile Number")
            }
        case otpTextField:
            if let text = otpTextField.text?.trimmed(), validate.numberValidation(text: text), let otp = Int(text), validate.otpTextCount(text: text), Set(String(otp)).count != 1 {
                otpTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = otpTextField.text, age.count <= 0 {
                otpTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                otpTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Invalid OTP")
            }
        case pinCodeTextField:
            if let text = pinCodeTextField.text, validate.isValidPIN(text: text), validate.pinCodeCount(text: text) {
                pinCodeTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = pinCodeTextField.text, age.count <= 0 {
                pinCodeTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                pinCodeTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Invalid Pin Code")
            }
        case passwordTextField.textField:
            if let text = passwordTextField.textField.text, validate.hasUpperCase(text), validate.hasNumber(text), validate.hasSymbol(text), text.count >= 8 {
                passwordTextField.textField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = passwordTextField.textField.text, age.count <= 0 {
                print("Empty details")
                passwordTextField.textField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                passwordTextField.textField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Invalid password")
            }
        case confirmPasswordTextField.textField:
            if let confirmText = confirmPasswordTextField.textField.text, let passwordText = passwordTextField.textField.text, confirmText == passwordText {
                confirmPasswordTextField.textField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = confirmPasswordTextField.textField.text, age.count <= 0 {
                print("Empty details")
                confirmPasswordTextField.textField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                confirmPasswordTextField.textField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Confirm password doesnot match")
            }
        default:
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case mobileTextField:
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return validate.isDigitsAcceptDeleteBackSpace(text: newText, maxLength: 10)
           // return validate.numberAllowedCharacteristics(text: string)
        case pinCodeTextField:
            return validate.pinCodeAllowedText(text: string)
        case ageTextField:
            let current = textField.text ?? ""
            let new = (current as NSString).replacingCharacters(in: range, with: string)
            return validate.isDigitsAcceptDeleteBackSpace(text: new)
        case otpTextField:
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return validate.isDigitsAcceptDeleteBackSpace(text: newText, maxLength: 4)
        default:
            return true
        }
    }
}
