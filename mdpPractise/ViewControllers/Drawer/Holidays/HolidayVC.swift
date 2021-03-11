//
//  HolidayVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit
import FSCalendar

class HolidayVC: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.indian)
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    private var currentPage: Date?

    private lazy var today: Date = {
        return Date()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupMethod()
        self.title = "Holidays"
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(addHoliDay))
    }
}


//MARK: HelpingMethod
extension HolidayVC {
    
    func SetupMethod(){
        self.calendar.delegate = self
        self.calendar.dataSource = self
        self.calendar.appearance.weekdayTextColor = UIColor(rgb: 0x0173B7)
        self.calendar.appearance.headerTitleColor = UIColor(rgb: 0x0173B7)
        self.calendar.appearance.headerTitleFont = UIFont(name:"Inter-Bold",size:15)
        self.calendar.appearance.eventDefaultColor = UIColor(red: 31/255.0, green: 119/255.0, blue: 219/255.0, alpha: 1.0)
        self.calendar.appearance.selectionColor = UIColor(rgb: 0x0173B7)
        self.calendar.appearance.headerDateFormat = "MMMM yyyy"
        self.calendar.appearance.todayColor = UIColor(red: 198/255.0, green: 51/255.0, blue: 42/255.0, alpha: 1.0)
        self.calendar.appearance.borderRadius = 1.0
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        self.calendar.headerHeight = 50
        self.calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        self.calendar.select(Date())
        let scopeGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        self.calendar.addGestureRecognizer(scopeGesture)
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
    }
    
}

//MARK: FSCalendarDataSource
extension HolidayVC : FSCalendarDataSource, FSCalendarDelegate {
    
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//
//        let dateString = self.formatter.string(from: date)
//        let faf = self.aptDateByMonthList.contains{ (amcData) -> Bool in
//            return amcData.dateString == dateString
//        }
//
//        if faf {
//            return 1
//        }
//
//        return 0
//    }
    
    // MARK:- FSCalendarDelegate
    
//    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//        print("change page to \(self.formatter.string(from: calendar.currentPage))")
//        currentYear = calendar.currentPage.year
//        currentMonth = calendar.currentPage.month
//        getAppointment()
//    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
}


extension HolidayVC {
    @objc func addHoliDay(){
        let story : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "AddHolidays") as! AddHolidays
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
