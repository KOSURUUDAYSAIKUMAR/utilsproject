//
//  FirebaseViewModel.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 27/12/23.
//

import UIKit
import FirebaseAuth

protocol LoginService {
    func login(username: String, password: String, success: @escaping (User, String) -> Void, failure: @escaping (Error?) -> Void)
}

protocol LoginFunctionProtocol {
    func login(username: String?, password: String?, type: LoginType)
    func create(username: String?, password: String?, type: LoginType)
    func sendPasswordResetEmail(email: String)
}

protocol LoginResultProtocol: AnyObject {
    func success(user: User?, type: LoginType)
    func error(error: Error, type: LoginType)
    func successAuth(error: Error?)
    func logoutOccur()
}

class FirebaseViewModel: LoginFunctionProtocol {
    var user: User?
    var token: String?
    weak var delegate: LoginResultProtocol?
    
    func login(username: String?, password: String?, type: LoginType) {
        if let username = username, let password = password {
            user = User(username: username, password: password, token: token)
            handleLogin(email: username, password: password)
        } else {
            delegate?.error(error: NSError(domain: "Value is nil", code: 1, userInfo:nil), type: type)
        }
    }
    
    func create(username: String?, password: String?, type: LoginType) {
        if let username = username, let password = password {
            user = User(username: username, password: password, token: token)
            createUser(email: username, password: password)
        } else {
            delegate?.error(error: NSError(domain: "Value is nil", code: 1, userInfo:nil), type: type)
        }
    }
    
    func isUserloggedIn() -> ((Bool), String?) {
        let newUserInfo = Auth.auth().currentUser
        let email = newUserInfo?.email
        return ((email != nil || email != ""), email)
    }
    
    private func login(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            guard error == nil else { return self.delegate!.successAuth(error: error) }
            delegate?.success(user: user, type: .normal)
        }
    }
  
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if let maybeError = error { //if there was an error, handle it
                let err = maybeError as NSError
                switch err.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    print("wrong password")
                case AuthErrorCode.invalidEmail.rawValue:
                    print("invalid email")
                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                    print("accountExistsWithDifferentCredential")
                default:
                    print("unknown error: \(err.localizedDescription)")
                }
            } else { //there was no error so the user could be auth'd or maybe not!
                if let _ = authResult?.user {
                    print("user is authd")
                } else {
                    print("no authd user")
                }
            }
            
            guard error == nil else { return self.delegate!.successAuth(error: error) }
            delegate?.success(user: user, type: .normal)
        }
    }
    
    func sendPasswordResetEmail(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { [self] (error) in
          if let error = error {
              let err = error as NSError
              switch err.code {
              case AuthErrorCode.userNotFound.rawValue:
                  print("sign-in provider is disabled")
              case AuthErrorCode.invalidEmail.rawValue:
                  print("The email address is badly formatted.")
              case AuthErrorCode.invalidRecipientEmail.rawValue:
                  print("Indicates an invalid recipient email was sent in the request.")
              case AuthErrorCode.invalidSender.rawValue:
                  print("Indicates an invalid sender email is set in the console for this action.")
              case AuthErrorCode.invalidMessagePayload.rawValue:
                  print("Indicates an invalid email template for sending update email.")
            default:
              print("Error message: \(error.localizedDescription)")
            }
          } else {
            print("Reset password email has been successfully sent")
          }
            delegate?.error(error: NSError(domain: error?.localizedDescription ?? "Reset password email has been successfully sent", code: 1, userInfo:nil), type: .normal)
        }
    }
    
    func sendUpdatePassword(password:String) {
        Auth.auth().currentUser?.updatePassword(to: password, completion: { [self] (error) in
          if let error = error {
              let err = error as NSError
            switch err.code {
            case AuthErrorCode.userDisabled.rawValue:
                print("The user account has been disabled by an administrator.")
            case AuthErrorCode.weakPassword.rawValue:
                print("The password must be 6 characters long or more.")
            case AuthErrorCode.operationNotAllowed.rawValue:
                print("sign-in provider is disabled for this Firebase project.")
            case AuthErrorCode.requiresRecentLogin.rawValue:
                print("user has not signed in recently enough.")
            default:
              print("Error message: \(error.localizedDescription)")
            }
          } else {
               print("User signs up successfully")
          }
            delegate?.error(error: NSError(domain: error?.localizedDescription ?? "User signs up successfully", code: 1, userInfo:nil), type: .normal)
        })
    }
    
    func updateEmailAddress(email: String) {
        Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: email, completion: { [self] (error) in
            if let error = error {
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.invalidRecipientEmail.rawValue:
                    print("Indicates an invalid recipient email was sent in the request.")
                case AuthErrorCode.invalidSender.rawValue:
                    print("Indicates an invalid sender email is set in the console for this action.")
                case AuthErrorCode.invalidMessagePayload.rawValue:
                    print("Indicates an invalid email template for sending update email.")
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    print("Email has been already used by another user.")
                case AuthErrorCode.invalidEmail.rawValue:
                    print("Email is not well formatted")
                case AuthErrorCode.requiresRecentLogin.rawValue:
                    print("Updating a user’s password is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser.")
                default:
                    print("Error message: \(error.localizedDescription)")
                }
            } else {
                print("Update email is successful")
            }
            delegate?.error(error: NSError(domain: error?.localizedDescription ?? "Update email is successful", code: 1, userInfo:nil), type: .normal)
        })
    }
    
    // MARK: - Action Handlers
    
    @objc
    private func handleLogin(email: String, password: String) {
        login(with: email, password: password)
    }
    
    @objc
    private func handleCreateAccount(email: String, password: String) {
        createUser(email: email, password: password)
    }
    
    // MARK: - Sign out
    func signOutHandler() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.delegate?.logoutOccur()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
