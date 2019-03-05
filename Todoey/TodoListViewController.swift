//
//  ViewController.swift
//  Todoey
//
//  Created by Patricio Soto on 2/28/19.
//  Copyright © 2019 Patricio Soto. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [String]()
    let defaults =  UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let items = defaults.array(forKey: "TodoListArray")
        if items != nil {
            self.itemArray = items as! [String]
        }
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = self.itemArray[indexPath.row]

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        if cell?.accessoryType == .checkmark{
            cell?.accessoryType = .none
        }else{
            cell?.accessoryType = .checkmark
        }
        
//
//        if newString == cell?.textLabel?.text {
//            cell?.textLabel?.text = self.itemArray[indexPath.row]
//        }else{
//            cell?.textLabel?.text = newString
//        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray,forKey : "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        self.present(alert,animated: true,completion: nil)
    }
    
    
}

