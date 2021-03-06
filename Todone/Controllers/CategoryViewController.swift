//
//  CategoryViewController.swift
//  Todone
//
//  Created by Josh Gressman on 3/18/18.
//  Copyright © 2018 Josh Gressman. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController{
    
    //Initialize a new RealmDB
    let realm = try! Realm()
    
    //Global properties
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
         loadCategory()
        
         tableView.separatorStyle = .none
    }

   
    
    //MARK: - Add new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //Alert pop up with text filed for new category
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add a new todo category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //What happens once use clicks add button
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.cellColor = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added"
      
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].cellColor ?? "1D9BF6")
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        return cell
        
    }
    
    
    //MARK: - TableView Delegate Methods > Triggered when a cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Navigate to item list view 
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    //Prepeare segue before navigating to the item list view > Intitalized just before perfromSeque
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
   
        //Get data from the selected row with category information
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory() {
    
    //get data from realmDB
     categories = realm.objects(Category.self)
    
        tableView.reloadData()

    }
    
    //DELETE Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category \(error)")
            }
        }
    }
    
}



