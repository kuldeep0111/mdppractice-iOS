//
//  HomeVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 02/02/21.
//

import UIKit
import SideMenu
import DropDown
import TTGSnackbar
import FSCalendar

class HomeVC: UIViewController, UINavigationBarDelegate {
    
    let dateFormatterGet = DateFormatter()
    var dropDown = DropDown()
    
    @IBOutlet weak var clinicName : UILabel!
    @IBOutlet weak var clinicLocation : UILabel!
    
    
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
    
    var clinicList : [ClinicListModel] = []
    var aptDateByMonthList : [AppointmentByMonthModel] = []
    
    var todayDate = Date()
    var currentMonth : Int?
    var currentYear : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupMethod()
        currentMonth = todayDate.month
        currentYear  = todayDate.year
        loadClinicList()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "menuLine")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(didTapOnMenuBtn(_:)))
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
}


//MARK: HelpingMethod
extension HomeVC {
    
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

//MARK: DataSource
extension HomeVC : FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let dateString = self.formatter.string(from: date)
        let faf = self.aptDateByMonthList.contains{ (amcData) -> Bool in
            return amcData.dateString == dateString
        }
        
        if faf {
            return 1
        }
        
        return 0
    }
    
    // MARK:- FSCalendarDelegate
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
        currentYear = calendar.currentPage.year
        currentMonth = calendar.currentPage.month
        getAppointment()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        let dateString = self.formatter.string(from: date)
        let faf = self.aptDateByMonthList.contains{ (amcData) -> Bool in
            return amcData.dateString == dateString
        }
        
        if faf {
            let vc = mdpStoryBoard.instantiateViewController(identifier: "AppointmentDetailsVC") as AppointmentDetailsVC
            vc.date = date
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            print(dateFormatter.string(from: date))
            AppointmentBlockView.showPopup(parentVC: self)
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
}

//MARK: Actions
extension HomeVC {
    
    
    @IBAction func monthForthButtonPressed(_ sender: Any) {
            
        self.moveCurrentPage(moveUp: true)
    }
        
    @IBAction func monthBackButtonPressed(_ sender: Any) {
            
        self.moveCurrentPage(moveUp: false)
    }

    private func moveCurrentPage(moveUp: Bool) {
            
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    
    @IBAction func didTapOnMenuBtn(_ sender: UIButton){
        // SJSwiftSideMenuController.toggleLeftSideMenu()
        let menu = storyboard!.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
        menu.settings.blurEffectStyle = .dark
        menu.settings.menuWidth = screenWidth - 50
        menu.settings.presentationStyle = .menuSlideIn
        menu.settings.statusBarEndAlpha = 0
        //SideMenuManager.default.lef = menu
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnSelectClinicBtn(_ sender: UIButton){
        
        var clinicName : [String] = []
        for item in clinicList {
            clinicName.append(item.clinicName)
        }
        
        dropDown.dataSource = clinicName//4
        dropDown.backgroundColor = UIColor(rgb: 0x0173b7)
        dropDown.textColor = UIColor.white
        dropDown.separatorColor = UIColor(rgb: 0x666666)
        dropDown.width = 150
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            self!.clinicName.text = item
            self!.clinicLocation.text = self!.clinicList[index].city
            selectedClinic = self!.clinicList[index]
            self!.getAppointment()
        }
    }
    
    @IBAction func didTapOnNotificationBtn(_ sender: UIButton){
        let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "NotificaitonVC") as! NotificaitonVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapOnAddBtn(_ sender: UIButton){
        let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "NewAppointmentVC") as! NewAppointmentVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupCurrentMonthYear(increase : Bool){
        if increase {
            if (currentMonth! < 12) {
                currentMonth = currentMonth! + 1
            }else{
                currentMonth = 1
                currentYear = currentYear! + 1
            }
        }else{
            if (currentMonth! == 1) {
                currentMonth = 12
                currentYear = currentYear! - 1
            }else{
                currentMonth = currentMonth! - 1
            }
        }
        getAppointment()
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

//MARK: API CALL

extension HomeVC {
    
    func loadClinicList(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        ClinicManager.sharedInstance.ClinicListList(completionHandler: {
            (success,list,error) in
            alert.dismiss(animated: true, completion: nil)
            if(success){
                self.clinicList = list
                self.clinicName.text = self.clinicList[0].clinicName
                self.clinicLocation.text = self.clinicList[0].city
                selectedClinic = self.clinicList[0]
                self.getAppointment()
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
    
    func getAppointment(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        AppointmentManager.sharedInstance.AppointmentByMonth(month: currentMonth, year: currentYear, clinicID: selectedClinic?.clinicID, completionHandler: {
            (success,data,error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alert.dismiss(animated: true, completion: nil)
                }
            if(success){
                self.aptDateByMonthList = data!
                self.calendar.reloadData()
            }else{
                
            }
        })
    }
}
