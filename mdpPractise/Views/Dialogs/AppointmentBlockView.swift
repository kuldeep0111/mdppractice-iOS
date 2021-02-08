//
//  AppointmentBlockView.swift
//  mdppractice
//
//  Created by Abhijeet Vijaivargia on 01/02/21.
//

import UIKit

protocol AppointmentBlockViewDelegate {
    func didTapOnBlockDate()
    func didTabOnAddNewAppointment()
}

class AppointmentBlockView: UIViewController {

    var delegate : AppointmentBlockViewDelegate?
    
    @IBOutlet weak var containerView : UIView!{
        didSet {
            containerView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var appointmentView : UIView!{
        didSet {
            appointmentView.layer.cornerRadius = 8
            appointmentView.layer.borderWidth = 2
                appointmentView.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var blockView : UIView!{
        didSet {
            blockView.layer.cornerRadius = 8
            blockView.layer.borderWidth = 2
            blockView.layer.borderColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1).cgColor
        }
    }
    @IBOutlet weak var blockImgView : UIImageView!{
        didSet{
            blockImgView.tintColor = UIColor.red
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMe))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
}

//MARK: Action's
extension AppointmentBlockView {
    
    @objc func dismissMe() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapOnNewAppointment(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        delegate?.didTabOnAddNewAppointment()
    }
    
    @IBAction func didTapOnBlockDate(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        delegate?.didTapOnBlockDate()
    }
    
    static func showPopup(parentVC: UIViewController){
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "CustomViews", bundle: nil).instantiateViewController(withIdentifier: "AppointmentBlockView") as? AppointmentBlockView {
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        popupViewController.delegate = parentVC as! AppointmentBlockViewDelegate
        parentVC.present(popupViewController, animated: true)
        }
      }
}
