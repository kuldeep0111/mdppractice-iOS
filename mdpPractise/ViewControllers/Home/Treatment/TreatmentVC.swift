//
//  TreatmentVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit
import DropDown
class TreatmentVC: UIViewController {
    
    let dropDown = DropDown()
    var parentVC : TreatmentVC?
    @IBOutlet weak var tableView : UITableView!
    
    let entries = [(doctorName: "Mr. Siddu Singh", treatmentNo: "TRP1081400160426"),
                   (doctorName: "Mr. ABC Sharma", treatmentNo: "TRP1081400160426"),
                   (doctorName: "Mr. GDT God", treatmentNo: "TRP1081400160426"),
                   (doctorName: "Mr. BHG Gahlot", treatmentNo: "TRP1081400160426"),(doctorName: "Mr. Siddu Singh", treatmentNo: "TRP1081400160426"),
                   (doctorName: "Mr. ABC Sharma", treatmentNo: "TRP1081400160426"),
                   (doctorName: "Mr. GDT God", treatmentNo: "TRP1081400160426"),
                   (doctorName: "Mr. BHG Gahlot", treatmentNo: "TRP1081400160426")]
    var searchResults : [(doctorName: String, treatmentNo: String)] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchButton : UIBarButtonItem?
    var isSearch = false
    
    let searchTextField = UITextField(frame: CGRect(x: 20, y: 100, width: screenWidth - 100, height: 40))
    
    var treatmentList: [TreatmentDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTreatments()
        self.navigationController?.title = "Treatments"
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 45, right: 0)
        //addSearchBar()
        
        
        searchButton = UIBarButtonItem(
            image: UIImage(named: "search")!.withRenderingMode(.alwaysTemplate),
            style: .plain, target: self, action: #selector(addSearchBar))
        
        navigationItem.rightBarButtonItem = searchButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
}

//MARK: Helping Method
extension TreatmentVC {
    
    @objc func addSearchBar(){
        if(searchButton!.image == UIImage.init(named: "cross")) {
            searchButton!.image = UIImage.init(named: "search")
        }else{
            searchButton!.image = UIImage.init(named: "cross")
        }
        if(isSearch != true){
            isSearch = true
            searchController.isActive = true
            searchController.searchResultsUpdater = self
            self.definesPresentationContext = true
            self.navigationItem.titleView = searchController.searchBar
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.searchBar.showsCancelButton = false
            //            searchController.searchBar.barTintColor = UIColor.white
            //            searchController.searchBar.placeholder = ""
            //            searchController.searchBar.tintColor = UIColor.white
            
        }else{
            isSearch = false
            searchController.isActive = false
            self.navigationItem.titleView = nil
            self.title = "Treatments"
        }
    }
}

extension TreatmentVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treatmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreatmentCell", for: indexPath) as! TreatmentCell
        cell.treatmentNo.text = treatmentList[indexPath.row].treatment
        cell.doctorName.text = treatmentList[indexPath.row].docName
        cell.date.text = "\(treatmentList[indexPath.row].treatmentDate)"
        cell.statusView.layer.cornerRadius = 5
        cell.phoneBtn.addTarget(self, action: #selector(didTapOnCall(_:)), for: .touchUpInside)
        cell.menuBtn.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "TreatmentDetailVC") as! TreatmentDetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TreatmentVC : UISearchResultsUpdating{
    func filterContent(for searchText: String) {
        // Update the searchResults array with matches
        // in our entries based on the title value.
        searchResults = entries.filter({ (doctorName: String, treatmentNo: String) -> Bool in
            let match = doctorName.range(of: searchText, options: .caseInsensitive)
            // Return the tuple if the range contains a match.
            return match != nil
        })
    }
    
    // MARK: - UISearchResultsUpdating method
    
    func updateSearchResults(for searchController: UISearchController) {
        // If the search bar contains text, filter our data with the string
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            // Reload the table view with the search result data.
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        tableView.reloadData()
    }
    
}

//MARK: Actions
extension TreatmentVC {
    
    @objc func didTapOnCall(_ sender: UIButton){
        
        if let url = URL(string: "tel://9886868688"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @objc func didTapOnMenuButton(_ sender: UIButton){
        
        dropDown.dataSource = ["Details", "Dental Images", "Prescription", "Payment"]//4
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
                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "TreatmentDetailVC") as! TreatmentDetailVC
                self?.navigationController?.pushViewController(vc, animated: true)
                break
            case 1:
                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "DentalImagesVC") as! DentalImagesVC
                self?.navigationController?.pushViewController(vc, animated: true)
               break
             
            case 2:
                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PrescriptionListVC") as! PrescriptionListVC
                self?.navigationController?.pushViewController(vc, animated: true)
               break

            case 3:
                let vc = mdpStoryBoard.instantiateViewController(withIdentifier: "PaymentDetailVC") as! PaymentDetailVC
                self?.navigationController?.pushViewController(vc, animated: true)
               break

            default:
                break
            }
        }
    }
}

//MARK: API CALL
extension TreatmentVC {
    
    func loadTreatments(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        TreatmentManager.sharedInstance.TreatmentList(completionHandler: {
                        (success,data,error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alert.dismiss(animated: true, completion: nil)
                }
            if(success){
                self.treatmentList = data!.treatmentList
                self.tableView.reloadData()
            }else{

            }
        })
    }
}
