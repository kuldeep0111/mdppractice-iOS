//
//  HomeVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 02/02/21.
//

import UIKit
import VACalendar
import SideMenu

class HomeVC: UIViewController {

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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "menuLine")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(didTapOnMenuBtn(_:)))
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
}


//MARK: DialogConfiguration

extension HomeVC {
    
    
}

//MARK: Actions
extension HomeVC {
    
    @IBAction func didTapOnMenuBtn(_ sender: UIButton){
       // SJSwiftSideMenuController.toggleLeftSideMenu()
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        
        menu.settings.blurEffectStyle = .dark
        menu.settings.menuWidth = screenWidth - 50
        menu.settings.presentationStyle = .viewSlideOutMenuIn
        //menu.settings.presentationStyle = .l
        
        present(menu, animated: true, completion: nil)
    }
    
}

extension HomeVC : AppointmentBlockViewDelegate {
    func didTapOnBlockDate() {
        let vc = mdpStoryBoard.instantiateViewController(identifier: "BlockDateVC") as! BlockDateVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTabOnAddNewAppointment() {
        let vc = mdpStoryBoard.instantiateViewController(identifier: "NewAppointmentVC") as! NewAppointmentVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

//MARK: VAMonthHeaderViewDelegate
extension HomeVC: VAMonthHeaderViewDelegate {
    
    func didTapNextMonth() {
        calendarView.nextMonth()
    }
    
    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
    
}

//MARK: VAMonthViewAppearanceDelegate
extension HomeVC: VAMonthViewAppearanceDelegate {
    
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

//MARK: VADayViewAppearanceDelegate
extension HomeVC: VADayViewAppearanceDelegate {
    
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

//MARK: VACalendarViewDelegate
extension HomeVC: VACalendarViewDelegate {
    
    func selectedDate(_ date: Date) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        print(dateFormatter.string(from: date))
        AppointmentBlockView.showPopup(parentVC: self)
        //MMM d, yyyy
    }
}
