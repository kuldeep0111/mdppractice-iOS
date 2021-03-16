//
//  TreatmentsVC.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit
import DropDown
class PatientListVC: UIViewController {

     var dropDown = DropDown()
    
    @IBOutlet weak var searchTextFiels : MDPTextField!{
        didSet{
            searchTextFiels.setLeftPaddingPoints(50)
            searchTextFiels.layer.cornerRadius = 25
            searchTextFiels.layer.borderColor = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
            searchTextFiels.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
            searchTextFiels.layer.borderWidth = 1
            searchTextFiels.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            searchTextFiels.font = UIFont.init(name: "Inter-Regular", size: 16)
            searchTextFiels.delegate = self
        }
    }
    
    @IBOutlet weak var tableView : UITableView!
    
    var isMDPMember = false
    var patientList: [PatientListModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = isMDPMember ? "MDP Members" : "Walk-in-Patients"
        setupNavigationBar()
        if isMDPMember {
            loadPatientList()
        }
    }
}

//MARK: UITextFieldDelegate
extension PatientListVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFiels.resignFirstResponder()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{

        let searchText  = textField.text! + string

        if searchText.count > 0 {
            tableView.isHidden = false

            patientList = PatientManager.sharedInstance.patientList.filter({ (result) -> Bool in
                return result.phoneNo.range(of: searchText, options: .caseInsensitive) != nil
            })
        }
        else{
            patientList = PatientManager.sharedInstance.patientList
        }
        tableView.reloadData()

        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if(textField.text?.count == 0){
            patientList = PatientManager.sharedInstance.patientList
            tableView.reloadData()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        patientList = PatientManager.sharedInstance.patientList
            tableView.reloadData()
    }
    
}

//MARK: Actions
extension PatientListVC {
    func setupNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(didTapOnAdd))
    }
        
    @objc func didTapOnAdd(){
        if(isMDPMember){
            let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "NewPatientVC") as! NewPatientVC
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
    }
}

extension PatientListVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell", for: indexPath) as! PatientCell
        cell.img.image = UIImage.init(named: "female")
        cell.name.text = patientList[indexPath.row].name
        cell.patientNo.text = patientList[indexPath.row].patientMember
        cell.subTitle.text = patientList[indexPath.row].isMember ? "Member" : "Walk-in"
        cell.phoneBtn.addTarget(self, action: #selector(didTapOnCall), for: .touchUpInside)
        cell.menuBtn.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = mdpStoryBoard.instantiateViewController(identifier: "NewPatientVC") as NewPatientVC
        vc.patientModel = patientList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PatientListVC : NewPatientVCDelegate {
    func updatePatientList() {
        loadPatientList()
    }
}


//MARK: Actions
extension PatientListVC {
    
    @objc func didTapOnCall(){
        
        if let url = URL(string: "tel://9886868688"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }    }
    
        
        @objc func didTapOnMenuButton(_ sender: UIButton){
            
            dropDown.dataSource = ["Treatment", "Medical History","Patient Log","Dental Images"]//4
            dropDown.backgroundColor = .white
            dropDown.textColor = UIColor(rgb: 0x666666)
            dropDown.separatorColor = UIColor(rgb: 0x666666)
            dropDown.width = 150
            dropDown.anchorView = sender //5
            dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
            dropDown.show() //7
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
                guard let _ = self else { return }
                switch index {
                case 3:
                    let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "DentalImagesVC") as! DentalImagesVC
                    self?.navigationController?.pushViewController(vc, animated: true)
                   break
    
                default:
                    break
                }
                
            }
            
        }
    }

//MARK: API CALL
extension PatientListVC {
    
    func loadPatientList(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: false, completion: nil)
        
        PatientManager.sharedInstance.PatientList(completionHandler: {(success,data,error)in
            self.dismiss(animated: false , completion: nil)
            if(success){
                self.patientList = data!
                self.tableView.reloadData()
            }else{
                
            }
        })
    }
}
