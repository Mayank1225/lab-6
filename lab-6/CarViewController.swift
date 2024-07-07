//
//  CarViewController.swift
//  lab-6
//
//  Created by user252704 on 7/5/24.
//

import UIKit

class CarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    public var header : UINavigationBar!
    
    @IBOutlet weak var editSwitch: UISwitch!
    
    struct Datalist {
        let Name: String
        let ImgName: String
        let detail: String
    }

    var data: [Datalist] = [
        Datalist(Name: "Toyota", ImgName: "img1", detail: "Camry, Sedan"),
        Datalist(Name: "Ford", ImgName: "img2", detail: "Mustang, Sports Car"),
        Datalist(Name: "Honda", ImgName: "img3", detail: "Civic, Sedan"),
        Datalist(Name: "Audi", ImgName: "img4", detail: "A4, Sedan"),
        Datalist(Name: "BMW", ImgName: "img5", detail: "X5, SUV"),
        Datalist(Name: "Tesla", ImgName: "img1", detail: "Model S, Electric Sedan"),
        Datalist(Name: "Chevrolet", ImgName: "img3", detail: "Silverado, Pickup Truck"),
        Datalist(Name: "Mercedes-Benz", ImgName: "img3", detail: "GLE, SUV")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab = UINavigationController(rootViewController: CarViewController())
        tab.title = "mk";
        editSwitch.setOn(false, animated: true)
        table.dataSource = self
        table.delegate = self
    }
    
    
    @IBAction func onEdit(_ sender: Any) {
        if table.isEditing == false {
            table.isEditing = true
        } else {
            table.isEditing = false
        }
    }
    
    @IBAction func onAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "Input", message: "Please Enter your ID", preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.placeholder = "Enter car name here"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Enter model here"
        }

        alertController.addTextField { textField in
            textField.placeholder = "Enter Style here"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        let applyAction = UIAlertAction(title: "Apply", style: .default) { _ in
            let carName = alertController.textFields?[0].text ?? ""
            let model = alertController.textFields?[1].text ?? ""
            let style = alertController.textFields?[2].text ?? ""

            var errorMessage = ""

            if carName.isEmpty {
                errorMessage += "Car name is required.\n"
            }
            if model.isEmpty {
                errorMessage += "Model is required.\n"
            }
            if style.isEmpty {
                errorMessage += "Style is required.\n"
            }

            if !errorMessage.isEmpty {
                let errorAlert = UIAlertController(title: "Please Enter below field", message: errorMessage, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(errorAlert, animated: true)
            } else {
                self.addItemInDataList(CarName: carName, CarModel: model, Style: style)
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(applyAction)

        self.present(alertController, animated: true)
    }
    
    func addItemInDataList(CarName: String, CarModel: String, Style: String) {
        let newItem = Datalist(Name: CarName, ImgName: "img3", detail: "\(CarModel), \(Style)")
            data.insert(newItem, at: 0)
            table.reloadData()
    }
    

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "carcell", for: indexPath) as! CarTableViewCell
        cell.Name.text = row.Name
        cell.carImage.image = UIImage(named: row.ImgName)
        cell.details.text = row.detail
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        data.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }

}
