//
//  AppointmentAcceptRejectView.swift
//  mdpPractise
//
//  Created by Abhijeet Vijaivargia on 09/02/21.
//

import UIKit

protocol AppointmentAcceptRejectViewDelegate{
    func didTapOnConfirm(isReject : Bool)
}

class AppointmentAcceptRejectView: UIViewController {

    var delegate : AppointmentAcceptRejectViewDelegate?
    
    @IBOutlet weak var containerView : UIView!{
        didSet{
            containerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var dialogTitle : UILabel!{
        didSet{
            dialogTitle.text = isReject ? "Reject" : "Accept"
        }
    }
    @IBOutlet weak var subTitle : UILabel!{
        didSet{
            subTitle.text = isReject ? "Reject asdfh alskdfjh aksdjfh kjsdfah jakshf " : "Accept falksd j alsdf lskdjf laskdfj alsdf k"
        }
    }
    @IBOutlet weak var confirmButton : UIButton!{
        didSet{
            confirmButton.backgroundColor = isReject ? UIColor.red : UIColor(rgb: 0x27AE60)
            confirmButton.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var cancelButton : UIButton!{
        didSet{
            cancelButton.layer.cornerRadius = 25
        }
    }

    var isReject = true
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnCancel(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)

        
    }
}

//MARK: Actions

extension AppointmentAcceptRejectView {
    
    @IBAction func didTapOnCancel(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnAcceptReject(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        delegate?.didTapOnConfirm(isReject: isReject)
    }
    
    static func showPopup(parentVC: UIViewController, isReject: Bool){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomViews", bundle: nil).instantiateViewController(withIdentifier: "AppointmentAcceptRejectView") as?
            AppointmentAcceptRejectView {
            popupViewController.modalPresentationStyle = .custom
            popupViewController.modalTransitionStyle = .crossDissolve
            popupViewController.delegate = parentVC as? AppointmentAcceptRejectViewDelegate
            popupViewController.isReject = isReject
            parentVC.present(popupViewController, animated: true)
        }
    }
}
