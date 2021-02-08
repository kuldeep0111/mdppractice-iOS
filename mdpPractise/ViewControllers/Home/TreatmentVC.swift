//
//  TreatmentVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 03/02/21.
//

import UIKit

class TreatmentVC: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    let entries = [(doctorName: "Mr. Siddu Singh", treatmentNo: "TRP1081400160426"),
                   (doctorName: "Mr. ABC Sharma", treatmentNo: "TRP1081400160426"),
                   (doctorName: "Mr. GDT God", treatmentNo: "TRP1081400160426"),
                   (doctorName: "Mr. BHG Gahlot", treatmentNo: "TRP1081400160426")]
       var searchResults : [(doctorName: String, treatmentNo: String)] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchButton : UIBarButtonItem?
    var isSearch = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Treatments"
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
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
        return searchController.isActive ? searchResults.count : entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreatmentCell", for: indexPath) as! TreatmentCell
        cell.treatmentNo.text = entries[indexPath.row].treatmentNo
        cell.doctorName.text = entries[indexPath.row].doctorName
        cell.date.text = "07/08/2020"
        cell.statusView.layer.cornerRadius = 5
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
