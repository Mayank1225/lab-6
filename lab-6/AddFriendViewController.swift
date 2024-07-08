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
 
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string.isEmpty {
                return true
            }

            if let currentText = textField.text,
               let rangeOfTextToReplace = Range(range, in: currentText),
               let number = Int(string),
               number >= 1, number <= 8,
               currentText.replacingCharacters(in: rangeOfTextToReplace, with: string).count <= 1 {
                return true
            }
            
            return false
        }
    
    func isValidSingleDigit(_ text: String?) -> Bool {
            guard let text = text, let number = Int(text), number >= 1, number <= 8, text.count == 1 else {
                return false
            }
            return true
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
        if !isValidSingleDigit(Food.text) {
                  errorMessage += "Food must be a single digit between 1 and 8.\n"
              }
              if !isValidSingleDigit(city.text) {
                  errorMessage += "City must be a single digit between 1 and 8.\n"
              }
              if !isValidSingleDigit(Sport.text) {
                  errorMessage += "Sport must be a single digit between 1 and 8.\n"
              }
        

        if !errorMessage.isEmpty {
            let errorAlert = UIAlertController(title: "Please Enter below field", message: errorMessage, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(errorAlert, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FriendViewController") as! FriendViewController
            data.insert(Datalist(FirstName: Name.text!, Phone:"+1\(Phone.text!)" , Email:"\(Email.text!)", CityImage: "city\(city.text!)", SportImage: "sp\(Sport.text!)", FoodImage: "food\(Food.text!)"), at: 0)
           
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
        Food.text = "";
        city.text = "";
        Sport.text = "";
    }
}
