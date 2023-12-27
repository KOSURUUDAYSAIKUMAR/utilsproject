//
//  GenderViewController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 21/12/23.
//

import UIKit

@objc protocol GenderDelegate: AnyObject {
    @objc optional func radioButtonSelect(text: String)
}

class GenderViewController: UIViewController {
    weak var delegate : GenderDelegate?
    
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: 250.0, height: 100.0)
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func okHandler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet private var multiRadioButton: [UIButton]!{
        didSet{
            multiRadioButton.forEach { (button) in
                button.setImage(UIImage(named:"circle_radio_unselected"), for: .normal)
                button.setImage(UIImage(named:"circle_radio_selected"), for: .selected)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func maleFemaleHandler(_ sender: UIButton) {
        uncheck()
        sender.checkboxAnimation { [self] in
            delegate?.radioButtonSelect?(text: sender.titleLabel?.text ?? "")
            print(sender.titleLabel?.text ?? "")
            print(sender.isSelected)
        }
        
        // NOTE:- here you can recognize with tag weather it is `Male` or `Female`.
        print(sender.tag)
    }
    
    func uncheck(){
        multiRadioButton.forEach { (button) in
            button.isSelected = false
        }
    }

}
