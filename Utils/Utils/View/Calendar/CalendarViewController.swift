//
//  CalendarViewController.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 22/12/23.
//

import UIKit

@objc protocol calendarDateSelectDelegate: AnyObject {
    @objc func selectedDate(text: String, tag: Int)
}
class CalendarViewController: UIViewController, FSCalendarDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var mainView: UIView!
    var buttonTag: Int = 0
    var previousMonth = 0
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    weak var calendarDelegate: calendarDateSelectDelegate?

    var calendarCurrent = ""
    
    init() {
        super.init(nibName: "CalendarViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.backgroundColor = .clear
        backgroundView.backgroundColor = .black.withAlphaComponent(0.6)
        backgroundView.alpha = 0
        mainView.alpha = 0
        mainView.layer.cornerRadius = 10
        calendar.layer.cornerRadius = 10
        
        calendar.select(Date())
        calendar.delegate = self
        calendar.scope = .month
        calendar.tintColor = .green
        // Do any additional setup after loading the view.
    }

    func appear(sender: ViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.2) {
            self.backgroundView.alpha = 1
            self.mainView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
            self.backgroundView.alpha = 0
            self.mainView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendarCurrent = dateFormatter.string(from: date)
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    @IBAction func calendarHandler(_ sender: UIButton) {
        if sender.tag == 0 {
            hide()
        } else {
            calendarDelegate?.selectedDate(text: calendarCurrent == "" ? dateFormatter.string(from: Date()) : calendarCurrent, tag: buttonTag)
            hide()
        }
    }
}

extension CalendarViewController: FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        switch buttonTag {
        case 1:
            if let lastMonthDate = getLastMonthDate(preMonth: previousMonth) {
                return lastMonthDate
            } else {
                return Date()
            }
        default:
            if let lastMonthDate = getLastMonthDate(preMonth: 120) {
                return lastMonthDate
            } else {
                return Date()
            }
        }
        
    }
    
    func getLastMonthDate(preMonth: Int) -> Date? {
        let calendar = Calendar.current
        let firstDayOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: Date()))!
        let previousMonth = calendar.date(byAdding: .month, value: -preMonth, to: firstDayOfCurrentMonth)!
        let firstDayOfPreviousMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: previousMonth))!
        return firstDayOfPreviousMonth
    }
}

