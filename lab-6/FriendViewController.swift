//
//  FriendViewController.swift
//  lab-6
//
//  Created by user252704 on 7/5/24.
//

import UIKit

struct Datalist {
    let FirstName: String
    let Phone: String
    let Email: String
    let CityImage: String
    let SportImage: String
    let FoodImage: String
}

var data: [Datalist] = [
    Datalist(FirstName: "John Doe", Phone: "+13845663389", Email: "john@gmail.com", CityImage: "city1", SportImage: "sp1", FoodImage: "food1"),
    Datalist(FirstName: "Jane Smith", Phone: "+13845663400", Email: "jane@gmail.com", CityImage: "city2", SportImage: "sp2", FoodImage: "food2"),
    Datalist(FirstName: "Michael Brown", Phone: "+13845663401", Email: "michael@gmail.com", CityImage: "city3", SportImage: "sp3", FoodImage: "food3"),
    Datalist(FirstName: "Emily Davis", Phone: "+13845663402", Email: "emily@gmail.com", CityImage: "city4", SportImage: "sp4", FoodImage: "food4"),
    Datalist(FirstName: "Chris Wilson", Phone: "+13845663403", Email: "chris@gmail.com", CityImage: "city5", SportImage: "sp5", FoodImage: "food5"),
    Datalist(FirstName: "Jessica Taylor", Phone: "+13845663404", Email: "jessica@gmail.com", CityImage: "city6", SportImage: "sp6", FoodImage: "food6"),
    Datalist(FirstName: "David Moore", Phone: "+13845663405", Email: "david@gmail.com", CityImage: "city7", SportImage: "sp7", FoodImage: "food7"),
    Datalist(FirstName: "Laura White", Phone: "+13845663406", Email: "laura@gmail.com", CityImage: "city8", SportImage: "sp8", FoodImage: "food8")
]


class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let switchControl = UISwitch()
                switchControl.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        switchControl.onTintColor = .systemBlue
                let switchBarItem = UIBarButtonItem(customView: switchControl)
                self.navigationItem.leftBarButtonItem = switchBarItem
        
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
