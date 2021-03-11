//
//  ClinicVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit
import DropDown
import TTGSnackbar

class ClinicVC: UIViewController {
    
    let dropDown = DropDown()
    @IBOutlet weak var searchTextFiels : UITextField!{
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
    
    var ClinicList: [ClinicListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadClinicList()
        self.title = "Clinic"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addAppointment")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(addNewClinic))
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 45, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        loadClinicList()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
}

//MARK: UITextFieldDelegate
extension ClinicVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFiels.resignFirstResponder()
    }
}

//MARK: Action
extension ClinicVC {
    @objc func addNewClinic(){
        let vc = mdpStoryBoard.instantiateViewController(identifier: "SetupClinicVC") as SetupClinicVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ClinicVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClinicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicCell", for: indexPath) as! ClinicCell
        cell.img.image = UIImage.init(named: "dentaldemo")
        cell.name.text = ClinicList[indexPath.row].clinicName
        cell.patientNo.text = "\(String(describing: ClinicList[indexPath.row].clinicID!))"
        cell.subTitle.text = ClinicList[indexPath.row].city
        cell.menuBtn.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = mdpStoryBoard.instantiateViewController(identifier: "ClinicDetails") as ClinicDetails
        vc.isAlreadyFeel = true
        vc.clinicID = ClinicList[indexPath.row].clinicID
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK : HelpingMethod

extension ClinicVC {
    
    @objc func didTapOnMenuButton(_ sender: UIButton){
        
        dropDown.dataSource = ["Staff", "Photos"]//4
        dropDown.backgroundColor = .white
        dropDown.textColor = UIColor(rgb: 0x666666)
        dropDown.separatorColor = UIColor(rgb: 0x666666)
        dropDown.width = 150
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            //sender.setTitle(item, for: .normal) //9
            
            switch index {
            case 0:
                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "StaffMemberVC") as! StaffMemberVC
                self?.navigationController!.pushViewController(vc, animated: true)
                break
            case 1:
                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "DentalImagesVC") as! DentalImagesVC
                self?.navigationController?.pushViewController(vc, animated: true)
               break
                
            default:
                break
            }
            
        }
        
    }
    
}


//MARK: Action
extension ClinicVC {
    
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alert.dismiss(animated: true, completion: nil)
                }
            if(success){
                self.ClinicList = ClinicManager.sharedInstance.clinicArray
                self.tableView.reloadData()
            }else{
                let snackbar = TTGSnackbar(message: error?.domain ?? "Something went wrong", duration: .long)
                snackbar.show()
            }
        })
    }
}
