//
//  FriendViewController.swift
//  lab-6
//
//  Created by user252704 on 7/5/24.
//

import UIKit

class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let switchControl = UISwitch()
                switchControl.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
                switchControl.onTintColor = .blue
                let switchBarItem = UIBarButtonItem(customView: switchControl)
                self.navigationItem.leftBarButtonItem = switchBarItem
        
        guard table != nil else {
                  print("Error: table outlet is not connected.")
                  return
              }
        
        table.dataSource = self
        table.delegate = self
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
           if sender.isOn {
               table.isEditing = true
           } else {
               table.isEditing = false
           }
       }
        
    struct Datalist {
        let FirstName: String
        let Phone: String
        let Email: String
        let CityImage: String
        let SportImage: String
        let FoodImage: String
    }

    var data: [Datalist] = [
        Datalist(FirstName: "Dell", Phone: "img1", Email: "RAM 4GB", CityImage: "img1", SportImage: "img2", FoodImage: "img3"),
        Datalist(FirstName: "Dell", Phone: "img1", Email: "RAM 4GB", CityImage: "img1", SportImage: "img2", FoodImage: "img3"),
        Datalist(FirstName: "Dell", Phone: "img1", Email: "RAM 4GB", CityImage: "img1", SportImage: "img2", FoodImage: "img3"),
        Datalist(FirstName: "Dell", Phone: "img1", Email: "RAM 4GB", CityImage: "img1", SportImage: "img2", FoodImage: "img3"),
        Datalist(FirstName: "Dell", Phone: "img1", Email: "RAM 4GB", CityImage: "img1", SportImage: "img2", FoodImage: "img3"),
    ]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "friendcell", for: indexPath) as! FriendTableViewCell
        cell.FirstName.text = row.FirstName
        cell.CityImage.image = UIImage(named: row.CityImage)
        cell.Phone.text = row.Phone
        cell.Email.text = row.Email
        cell.SportImage.image = UIImage(named: row.SportImage)
        cell.FoodImage.image = UIImage(named: row.FoodImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
