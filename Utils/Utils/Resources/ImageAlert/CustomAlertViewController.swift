//
//  CustomAlertViewController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 20/12/23.
//

import UIKit

class CustomAlertViewController: UIViewController {

    weak var delegate : AlertDialogDelegate?
    var buttonsCount : Int = 0
    
    @IBOutlet weak var viewYN: UIView!
    
    @IBOutlet weak var viewOk: UIView!
    
    override var preferredContentSize: CGSize {
        get {
            return CGSize(width: 300.0, height: 120.0)
        }
        set {
            super.preferredContentSize = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch buttonsCount {
        case 1:
            viewYN.alpha = 0
            viewOk.alpha = 1
        default:
            viewOk.alpha = 0
            viewYN.alpha = 1
        }
        view.addBorderAndColor(color: .white, width: 1, corner_radius: 5, clipsToBounds: true)
        // Do any additional setup after loading the view.
    }

    @IBAction func ButtonHandler(_ sender: UIButton) {
        delegate?.alertButtonTagYN?(tag: sender.titleLabel?.text ?? "")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
