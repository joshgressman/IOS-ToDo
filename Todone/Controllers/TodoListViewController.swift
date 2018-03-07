//
//  ViewController.swift
//  Todone
//
//  Created by Josh Gressman on 3/1/18.
//  Copyright © 2018 Josh Gressman. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //Array of Item Object from the Item data model
    var itemArray = [Item]()

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Using Item data model class / object
        let newItem = Item()
        newItem.title = "Do all the things"
        itemArray.append(newItem)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
    }

  //MARK - Tableview Datasouce Methods
  
    //Set number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return itemArray.count
    }
    
    //Assign Data to table rows ToDoItemCell is the identifyer for the table view cell and the indexPath is the array index
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //Access text properties for the tableView label
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //Value = condition ? valueTruee : valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    //Did Select promps data from the row selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        //Add a check mark when tableview is selected or remove if selected
        
        //Not Operator in place if if/else chaning to oppasate with ! since bools can have 1 of 2 states true/false
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//           itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
       
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //Create alert controller for new todo item input
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        //Alert Button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when the user clicks the add item button
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            //save data to userDefaults - Local Storage
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            print("Success")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
//End of class
}

