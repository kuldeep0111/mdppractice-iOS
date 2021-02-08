//
//  HolidayVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit
import VACalendar

class HolidayVC: UIViewController {

    let dateFormatterGet = DateFormatter()
    
    @IBOutlet weak var monthHeaderView: VAMonthHeaderView! {
           didSet {
               let appereance = VAMonthHeaderViewAppearance(
                previousButtonImage: (UIImage.init(named: "leftArrow")?.withTintColor(UIColor(rgb: 0x0173B7), renderingMode: .alwaysOriginal))!,
                nextButtonImage: (UIImage.init(named: "rightArrow")?.withTintColor(UIColor(rgb: 0x0173B7), renderingMode: .alwaysOriginal))!,
                   dateFormatter: dateFormatterGet
               )
               monthHeaderView.delegate = self
               monthHeaderView.appearance = appereance
           }
       }
       
       @IBOutlet weak var weekDaysView: VAWeekDaysView! {
           didSet {
               let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
               weekDaysView.appearance = appereance
           }
       }
    
    var calendarView: VACalendarView!
    
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Holidays"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(addHoliDay))
        
        dateFormatterGet.dateFormat = "MMMM yyyy"
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = true
        calendarView.selectionStyle = .single
        calendarView.monthDelegate = monthHeaderView
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        view.addSubview(calendarView)

    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            if calendarView.frame == .zero {
                calendarView.frame = CGRect(
                    x: 0,
                    y: weekDaysView.frame.maxY,
                    width: view.frame.width,
                    height: view.frame.height * 0.6
                )
                calendarView.setup()
            }
        }
}

extension HolidayVC {
    @objc func addHoliDay(){
        let story : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "AddHolidays") as! AddHolidays
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension HolidayVC: VAMonthHeaderViewDelegate {
    
    func didTapNextMonth() {
        calendarView.nextMonth()
    }
    
    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
    
}

extension HolidayVC: VAMonthViewAppearanceDelegate {
    
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return UIColor(rgb: 0x0173B7)
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return UIColor(rgb: 0x0173B7)
    }
    
}

extension HolidayVC: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return .black
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return UIColor(rgb: 0x0173B7)
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
    
}

extension HolidayVC: VACalendarViewDelegate {
    
    func selectedDates(_ dates: [Date]) {
        calendarView.startDate = dates.last ?? Date()
        print(dates)
    }
}
