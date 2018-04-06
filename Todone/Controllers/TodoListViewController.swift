//
//  ViewController.swift
//  Todone
//
//  Created by Josh Gressman on 3/1/18.
//  Copyright © 2018 Josh Gressman. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoListViewController: SwipeTableViewController {
    
    //Array of Item Object from the Item data model
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    //initialezs when value is set
    var selectedCategory : Category? {
        didSet{
        loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
       
    }

  //MARK - Tableview Datasouce Methods
  
    //Set number of rows in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return todoItems?.count ?? 1
    }
    
    
    //Assign Data to table rows ToDoItemCell is the identifyer for the table view cell and the indexPath is the array index
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       //Inherit from super class
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        //Access text properties for the tableView label
        
        if let item = todoItems?[indexPath.row] {
         cell.textLabel?.text = item.title
         
            if let color = UIColor(hexString: selectedCategory!.cellColor)?.darken(byPercentage:CGFloat(indexPath.row ) / CGFloat(todoItems!.count)) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
            }
            
           
            
            //Ternary operator ==>
            //Value = condition ? valueTruee : valueIfTrue : valueIfFalse
         cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added"
        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    //Did Select promps data from the row selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //update data when item is selected in realm
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                 //save updated attribute with opposite using !
                 item.done = !item.done
                }
            } catch {
                print("Error updating \(error)")
            }
        }
       tableView.reloadData()
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //Create alert controller for new todo item input
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        //Alert Button
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What happens when the user clicks the add item button
            
            //if not = to nil
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
                } catch {
                    print("Error while saving \(error)")
                }
            }
            self.tableView.reloadData()
        
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Save data method
 
    
    //Get from core data with defualt value of Item.fetchRequest() all items
    func loadItems() {
       todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
    
    //DELETE Data From Swipe ovveride from super delete
    override func updateModel(at indexPath: IndexPath) {
        if let item = self.todoItems?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print("Error deleting todo item \(error)")
            }
        }
    }
    
//End of class
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {

                searchBar.resignFirstResponder()
            }

        }
    }


}

