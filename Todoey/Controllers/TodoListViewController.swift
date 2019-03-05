//
//  ViewController.swift
//  Todoey
//
//  Created by Patricio Soto on 2/28/19.
//  Copyright © 2019 Patricio Soto. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaults =  UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        loadItems()
        
//        let items = defaults.array(forKey: "TodoListArray2")
//        var item1 = Item()
//        item1.title = "Task 1"
//        itemArray.append(item1)
//
//        var item2 = Item()
//        item2.title = "Task 2"
//        itemArray.append(item2)
        
        
//        if items != nil {
//            self.itemArray = items as! [Item]
//        }
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = self.itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let item = self.itemArray[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        item.done = !item.done
        cell?.accessoryType = item.done ? .checkmark : .none
        
        saveItems ()
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let item = Item()
            item.title = textField.text!
            self.itemArray.append(item)
            
            self.saveItems ()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        self.present(alert,animated: true,completion: nil)
    }
    
    func saveItems () {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error ecoding item array")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Items")
            }
            
        }
    }
    
    
}

