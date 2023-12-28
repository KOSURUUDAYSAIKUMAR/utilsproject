//
//  PasswordTextField.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 28/12/23.
//

import UIKit

@objc protocol isVisiblePasswordProtocol: AnyObject {
    @objc func isvisiblepassword(status: Bool)
}

class PasswordTextField: UIView {

    @IBOutlet weak var visibleButton: UIButton!
    @IBOutlet weak var textField: UITextField!

    private let placeholderColor = UIColor(red: 122.5/255, green: 121.5/255, blue: 120.25/255, alpha: 0.7)
    
    weak var delegate : isVisiblePasswordProtocol?
    
    var placeholderText: String = "" {
      didSet {
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
      }
    }
    
    var text: String? {
      return textField.text
    }
    // MARK: - Initializer
    override init(frame: CGRect) {
      super.init(frame: frame)
      
      self.loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.loadFromNib()
    }
    
    func loadFromNib() {
      if let contentView = Bundle.main.loadNibNamed("PasswordTextField", owner: self, options: nil)?.first as? UIView {
        contentView.frame = bounds
        addSubview(contentView)
      }
    }
    
    @IBAction func visibleHandler(_ sender: UIButton) {
        textField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
}
