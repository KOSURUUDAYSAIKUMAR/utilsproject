//
//  ValidationTableViewCell.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 19/12/23.
//

import UIKit

class ValidationTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var otpTextField: UITextField!
    
    @IBOutlet weak var pinCodeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
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
        if let confirmText = confirmPasswordTextField.text, let passwordText = passwordTextField.text, confirmText == passwordText {
            confirmPasswordTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
        } else if let age = confirmPasswordTextField.text, age.count <= 0 {
            print("Empty details")
            confirmPasswordTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
        } else {
            confirmPasswordTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
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
        nameTextField.delegate = self
        ageTextField.delegate = self
        mailTextField.delegate = self
        mobileTextField.delegate = self
        otpTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        pinCodeTextField.delegate = self
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
        return nameTextField.text?.isEmpty ?? true &&
        ageTextField.text?.isEmpty ?? true &&
        mailTextField.text?.isEmpty ?? true &&
        mobileTextField.text?.isEmpty ?? true &&
        otpTextField.text?.isEmpty ?? true &&
        passwordTextField.text?.isEmpty ?? true &&
        confirmPasswordTextField.text?.isEmpty ?? true &&
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
        case nameTextField:
            if validate.isValidFullName(nameTextField.text ?? "") {
                nameTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = nameTextField.text, age.count <= 0 {
                print("Empty details")
                nameTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                nameTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Invalid name")
            }
        case ageTextField:
            if let age = ageTextField.text?.trimmed(), validate.ageCount(text: age) {
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
        case passwordTextField:
            if let text = passwordTextField.text, validate.hasUpperCase(text), validate.hasNumber(text), validate.hasSymbol(text), text.count >= 8 {
                passwordTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = passwordTextField.text, age.count <= 0 {
                print("Empty details")
                passwordTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                passwordTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Invalid password")
            }
        case confirmPasswordTextField:
            if let confirmText = confirmPasswordTextField.text, let passwordText = passwordTextField.text, confirmText == passwordText {
                confirmPasswordTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else if let age = confirmPasswordTextField.text, age.count <= 0 {
                print("Empty details")
                confirmPasswordTextField.addBorderAndColor(color: .lightGray, width: 0.5, corner_radius: 5, clipsToBounds: true)
            } else {
                confirmPasswordTextField.addBorderAndColor(color: UIColor.red, width: 0.5, corner_radius: 5, clipsToBounds: true)
                delegate?.showAlert?(msg: "Confirm password doesnot match")
            }
        default:
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case mobileTextField:
            return validate.numberAllowedCharacteristics(text: string)
        case pinCodeTextField:
            return validate.pinCodeAllowedText(text: string)
        default:
            return true
        }
    }
}
