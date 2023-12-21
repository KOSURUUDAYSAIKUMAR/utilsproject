//
//  AlertDialogTableViewCell.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 20/12/23.
//

import UIKit

@objc protocol AlertDialogDelegate: AnyObject {
    @objc optional func alertButtonTag(tag: Int)
    @objc optional func alertButtonTagYN(tag: String)
}

class AlertDialogTableViewCell: UITableViewCell {

    @IBOutlet weak var alertOutlet: UIButton!
    
    weak var delegate : AlertDialogDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        alertOutlet.addBorderAndColor(color: .systemBlue, width: 1, corner_radius: 5, clipsToBounds: true)
        // Initialization code
    }

    func setupUI(data: String) {
        alertOutlet.setTitle(data, for: .normal)
    }
    
    @IBAction func alertHandler(_ sender: UIButton) {
        delegate?.alertButtonTag?(tag: sender.tag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
