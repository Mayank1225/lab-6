//
//  AddFriendViewController.swift
//  lab-6
//
//  Created by user252704 on 7/6/24.
//

import UIKit

class AddFriendViewController: UIViewController {

    @IBOutlet weak var Name: UITextField!
    
    
    @IBOutlet weak var Phone: UITextField!
    
    @IBOutlet weak var Food: UITextField!
    
    @IBOutlet weak var Sport: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var Email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    
    @IBAction func onNameChange(_ sender: Any) {
//        addTextInView()
    }
    
    @IBAction func OnPhoneChange(_ sender: Any) {
//        addTextInView()
    }
    
    @IBAction func OnEmailChange(_ sender: Any) {
//        addTextInView()
    }
    
    @IBAction func AddBtn(_ sender: Any) {
        var errorMessage = ""

        if Name.text?.isEmpty == true {
            errorMessage += "Friend name is required.\n"
        }
        if Phone.text?.isEmpty == true {
            errorMessage += "Phone is required.\n"
        }
        if Email.text?.isEmpty == true {
            errorMessage += "Email is required.\n"
        }

        if !errorMessage.isEmpty {
            let errorAlert = UIAlertController(title: "Please Enter below field", message: errorMessage, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(errorAlert, animated: true)
        } else {
//            self.addItemInDataList(FirstName: Name.text!, Phone: Phone.text!, Email: Email.text!)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FriendViewController") as! FriendViewController
            vc.data.insert(FriendViewController.Datalist(FirstName: Name.text!, Phone: Phone.text!, Email: Email.text!, CityImage: "img2", SportImage: "img1", FoodImage: "img3"), at: 0)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func ClearBtn(_ sender: Any) {
        clearInfo()
    }
    
    func clearInfo() {
        Name.text = "";
        Phone.text = "";
        Email.text = "";
    }
}
