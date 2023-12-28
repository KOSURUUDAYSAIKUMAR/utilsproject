//
//  AlertDialogTableViewCell.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 20/12/23.
//

import UIKit

@objc protocol AlertDialogDelegate: AnyObject {
    @objc func alertButtonTag(tag: Int)
    @objc optional func alertButtonTagYN(tag: String)
    @objc func progressBar(tag:Int)
    @objc func bottomSheet()
    @objc func authentication()
}

class AlertDialogTableViewCell: UITableViewCell {

    @IBOutlet weak var alertOutlet: UIButton!
    
    weak var delegate : AlertDialogDelegate?
    var section = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        alertOutlet.addBorderAndColor(color: .systemBlue, width: 1, corner_radius: 5, clipsToBounds: true)
        // Initialization code
    }

    func setupUI(data: String, tag: Int) {
        alertOutlet.setTitle(data, for: .normal)
        section = tag
    }
    
    @IBAction func alertHandler(_ sender: UIButton) {
        switch section {
        case 1:
            delegate?.alertButtonTag(tag: sender.tag)
        case 2:
            delegate?.progressBar(tag: sender.tag)
        case 6:
            delegate?.authentication()
        default:
            delegate?.bottomSheet()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
