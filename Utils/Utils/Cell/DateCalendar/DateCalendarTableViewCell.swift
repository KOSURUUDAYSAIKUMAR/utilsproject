//
//  DateCalendarTableViewCell.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 21/12/23.
//

import UIKit

@objc protocol DateFormatDelegate: AnyObject {
    @objc func dateFilteredCases(date: [String])
    @objc func presentPopupViewController(_ viewController: UIViewController)

}
class DateCalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var dateFormat: UITextField!
    @IBOutlet weak var setDateTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var calendarTextField: UITextField!
    @IBOutlet weak var restrictMonth: UITextField!
    @IBOutlet weak var previousCalendarDate: UITextField!
    
    weak var dateDelegate: DateFormatDelegate?
    let centeredDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [centeredDropDown]
    }()
    var filteredCases = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateLabel.text = "Eg: dd-MM-YY, dd-MM-YYYY, MM-dd-YYYY, yyyy-MM-dd, YYYY-MM-dd HH:mm, YYYY-MM-dd HH:mm:ss"
        dateFormat.delegate = self
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
    }

    func setupUI() {
      
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func calendarHandler(_ sender: UIButton) {
        let popupViewController = CalendarViewController()
        popupViewController.calendarDelegate = self
        popupViewController.buttonTag = sender.tag
        popupViewController.previousMonth = Int(restrictMonth.text?.trimmed() ?? "") ?? 120
        popupViewController.modalPresentationStyle = .custom
        popupViewController.transitioningDelegate = self
        dateDelegate?.presentPopupViewController(popupViewController)
    }
}

extension DateCalendarTableViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        filteredCases = ["dd MMM yyyy HH:mm zzz", "dd MMM yyyy HH:mm", "dd-MM-yy", "dd-MM-yyyy"]
//        centeredDropDown.show()
//        dropDownHandler()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateFormat {
            if let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
                // filteredCases = DateFormate.filterCases(startingWith: text)
                filteredCases = DateFormate.filterCases(startingWith: text, caseSensitive: true)
                print("Filtered cases: \(filteredCases)")
                dateDelegate?.dateFilteredCases(date: filteredCases)
                DispatchQueue.main.async(group: .none, qos: .background, execute: { [self] in
                    centeredDropDown.show()
                    dropDownHandler()
                })
            }
        }
        return true
    }
    
    func dropDownHandler() {
        centeredDropDown.anchorView = dateFormat
        centeredDropDown.dataSource = filteredCases
        centeredDropDown.selectionAction = { [self] (index, item) in
            print("Item ", item)
            dateFormat.text = item
            setDateTextField.text = Date().convertToString(formate: item)
            centeredDropDown.hide()
        }
    }
}

extension DateCalendarTableViewCell: calendarDateSelectDelegate {
    func selectedDate(text: String, tag: Int) {
        if tag == 0 {
            calendarTextField.text = text
        } else {
            previousCalendarDate.text = text
        }
    }
}

extension DateCalendarTableViewCell: UIViewControllerTransitioningDelegate {
    
}
