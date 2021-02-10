//
//  DentalImagesVC.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 04/02/21.
//

import UIKit

class DentalImagesVC: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos"
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMainCollectionViewLayout()
    }
    
    func setMainCollectionViewLayout(){
        let layout1 = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        let cellwidth = (width - 25)/2
        layout1.itemSize = CGSize(width: cellwidth, height: cellwidth)
        layout1.scrollDirection = .vertical
        layout1.minimumLineSpacing = 5
        layout1.minimumInteritemSpacing = 5
        layout1.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.setCollectionViewLayout(layout1, animated: true)
    }
}

extension DentalImagesVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DentalImageCell", for: indexPath) as! DentalImageCell
        cell.img.image = UIImage.init(named: "dentaldemo")
        cell.name.text = "Front View"
        cell.date.text = "07/07/2020"
        return cell
    }
}
