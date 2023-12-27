//
//  FireBaseViewController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 27/12/23.
//

import UIKit

class FireBaseViewController: BaseViewController {

    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    let viewModel = FirebaseViewModel()
    
    @IBOutlet weak var forgotPwd: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Is user logged in ", viewModel.isUserloggedIn().1)
        userNameTextField.placeholderText = "Username"
        passwordTextField.placeholderText = "Password"
        signInButton.corner()
        signUpButton.corner()
        forgotPwd.corner(radius: 5.0)
        stackView.corner(radius: 5.0)
        viewModel.delegate = self
        configureNavigationBar()
    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//      super.viewWillAppear(animated)
//      navigationController?.setTitleColor(.label)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//      super.viewWillDisappear(animated)
//      view.endEditing(true)
//      navigationController?.setTitleColor(.systemOrange)
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//      super.viewDidDisappear(animated)
//      navigationController?.popViewController(animated: false)
//    }
//
//    // Dismisses keyboard when view is tapped
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//      super.touchesBegan(touches, with: event)
//      view.endEditing(true)
//    }
    
    @IBAction func didTapSignInButton(_ sender: Any) {
      viewModel.login(username: userNameTextField.text, password: passwordTextField.text, type: .normal)
    }
    
    @IBAction func didTapSignUpButton(_ sender: Any) {
        viewModel.create(username: userNameTextField.text, password: passwordTextField.text, type: .normal)
    }
    @IBAction func logoutHandler(_ sender: Any) {
        viewModel.signOutHandler()
    }
    
    @IBAction func forgotPasswordHandler(_ sender: Any) {
        viewModel.sendPasswordResetEmail(email: userNameTextField.text ?? "")
    }
    
    func updatePassword() {
        viewModel.sendUpdatePassword(password: passwordTextField.text ?? "")
    }
    
    // MARK: - UI Configuration
    private func configureNavigationBar() {
        navigationItem.title = "Welcome"
        navigationItem.backBarButtonItem?.tintColor = .primaryColor
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension FireBaseViewController: LoginResultProtocol {
    func successAuth(error: Error?) {
        AlertHelperModel.showAlert(title: "Error", message: "\(error?.localizedDescription)\n\n Ocurred in \(self)", viewController: self)
    }
    
    func logoutOccur() {
        AlertHelperModel.showAlert(title: "Utils", message: "You have successfully logged out", viewController: self)
    }
  
  func showPopup(isSuccess: Bool, user: User? = nil, type: LoginType) {
      let successMessage = "Congratulation! \(user?.username ?? ""). You logged in successully with \(type.name). "
      let errorMessage = "Something went wrong. Please try again"
      AlertHelperModel.showAlert(title: isSuccess ? "Success": "Error", message: isSuccess ? successMessage: errorMessage, viewController: self)
  }
  
  func success(user: User?, type: LoginType) {
    showPopup(isSuccess: true, user: viewModel.user, type: type)
  }
  
  func error(error: Error, type: LoginType) {
    showPopup(isSuccess: false, type: type)
  }
}

// MARK: - UITextFieldDelegate

extension FireBaseViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if userNameTextField.isFirstResponder, passwordTextField.text!.isEmpty {
      passwordTextField.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return true
  }
}
