//
//  TodoViewController.swift
//  lab-6
//
//  Created by user252704 on 7/6/24.
//

import UIKit

class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

        @IBOutlet weak var todo: UITextField!
    @IBOutlet weak var section: UITextField!
    @IBOutlet weak var table: UITableView!
    
    struct ToDoSection {
        var title: String
        var items: [String]
    }
    
    var selectedSectionIndex: Int?

    var sections: [ToDoSection] = [
        ToDoSection(title: "Kitchen Chores", items: ["Wash dishes", "Clean platform"]),
        ToDoSection(title: "Outdoor Chores", items: ["Water plants"]),
        ToDoSection(title: "Grocery Shopping", items: ["Buy milk", "Buy vegetables", "Buy fruits"]),
        ToDoSection(title: "Office Work", items: ["Finish report", "Email clients", "Team meeting"]),
        ToDoSection(title: "Exercise", items: ["Morning run", "Yoga session"]),
        ToDoSection(title: "Reading", items: ["Read novel", "Read news"]),
        ToDoSection(title: "House Maintenance", items: ["Fix the door", "Paint wall"]),
        ToDoSection(title: "Miscellaneous", items: ["Call mom", "Plan weekend trip"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
    }
    
    
    
    @IBAction func clearBtn(_ sender: Any) {
        selectedSectionIndex = nil
        section.text = ""
        todo.text = ""
    }
    
    @IBAction func onEdit(_ sender: Any) {
        if table.isEditing == false {
            table.isEditing = true
        } else {
            table.isEditing = false
        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let sectionText = section.text ?? ""
          let todoText = todo.text ?? ""

          var errorMessage = ""

          if sectionText.isEmpty {
              errorMessage += "Section is required.\n"
          }
          if todoText.isEmpty {
              errorMessage += "Todo item is required.\n"
          }

          if !errorMessage.isEmpty {
              let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
              return
          }
        
        if let sectionIndex = sections.firstIndex(where: { $0.title == section.text! }) {
            sections[sectionIndex].items.append(todo.text!)
                   table.reloadSections(IndexSet(integer: sectionIndex), with: .automatic)
               } else {
                   let newSection = ToDoSection(title: section.text!, items: [todo.text!])
                   sections.insert(newSection, at: 0)
                   table.reloadData()
                   
               }
        todo.text = ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "✨ \(sections[section].title)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! TodoTableViewCell
        let section = sections[indexPath.section]
        cell.todoItem.text = "• \(section.items[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sections[indexPath.section].items.remove(at: indexPath.row)
            
            if sections[indexPath.section].items.isEmpty {
                sections.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = sections[sourceIndexPath.section].items.remove(at: sourceIndexPath.row)
        sections[destinationIndexPath.section].items.insert(movedItem, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSectionIndex = indexPath.section
        section.text = sections[indexPath.section].title
        todo.text = sections[indexPath.section].items[indexPath.row]
    }
}
