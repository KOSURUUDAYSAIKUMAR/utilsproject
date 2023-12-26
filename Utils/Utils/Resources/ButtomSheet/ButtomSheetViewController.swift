//
//  ButtomSheetViewController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 26/12/23.
//

import UIKit

class ButtomSheetViewController: BottomSheetController {

    @IBOutlet weak var feedbackTextView: UITextView!
    
    @IBOutlet weak var placeholderLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackTextView.delegate = self
        feedbackTextView.addBorderAndColor(color: .black, width: 1, corner_radius: 5, clipsToBounds: true)
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonHandler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ButtomSheetViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "" {
            placeholderLabel.text = "Share your feedback ..!"
        } else {
            placeholderLabel.text = ""
        }
    }
}
