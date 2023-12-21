//
//  CustomHeaderView.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 19/12/23.
//

import UIKit

protocol CustomeHeaderViewDelegate: AnyObject {
    func headerViewTap(_ section: Int)
}

class CustomHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var arrowOutlet: UIButton!
    weak var delegate: CustomeHeaderViewDelegate?
    var sectionNumber: Int!
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        addBorderAndColor(color: .white, width: 1, corner_radius: 5, clipsToBounds: true)
       let gesture = UITapGestureRecognizer(target: self, action: #selector(CustomHeaderView.tableViewSectionTapped(_:)))
       self.addGestureRecognizer(gesture)
       let backgroundView = UIView(frame: self.bounds)
       backgroundView.backgroundColor = UIColor.systemBlue
       self.backgroundView = backgroundView
   }

   @objc func tableViewSectionTapped(_ gesture: UIGestureRecognizer) {
       arrowOutlet.isSelected.toggle()
       delegate?.headerViewTap(self.sectionNumber)
   }
    
    @IBAction func arrowHandler(_ sender: Any) {
        arrowOutlet.isSelected.toggle()
        delegate?.headerViewTap(self.sectionNumber)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
