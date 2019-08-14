//
//  ShoppingListTableViewController.swift
//  shoppingListRev2
//
//  Created by Julia Rodriguez on 8/13/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, ShoppingItemTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ShoppingListController.sharedInstance.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItem", for: indexPath) as? ShoppingItemTableViewCell else { return UITableViewCell() }
        
        let item = ShoppingListController.sharedInstance.items[indexPath.row]
        
        // call func from CustomViewCell, to update item, this sends data to Custom View Cell
        cell.update(item: item)
        
        cell.delegate = self

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = ShoppingListController.sharedInstance.items[indexPath.row]
            
            ShoppingListController.sharedInstance.remove(shoppingItem: item)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        addNewGroceryItem()
    }
    
    // display alert controller func
    func addNewGroceryItem() {
        
        let alert = UIAlertController(title: "Grocery Item", message: "Please enter a new item to your shopping list", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter new item here..."
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .words
        }
        
        // add "add" action
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            
            guard let item = alert.textFields?[0].text else { return }
            ShoppingListController.sharedInstance.add(itemWithName: item)
            self.tableView.reloadData()
        }))
        // add "cance" action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // present complete alert view
        self.present(alert, animated: true, completion: nil)
    }
    
    // protocol from CustomViewCell which delegate will execute
    func shoppingItemTapped(_ sender: ShoppingItemTableViewCell) {
        // identify an indexPath
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        
        let item = ShoppingListController.sharedInstance.items[indexPath.row]
        
        ShoppingListController.sharedInstance.toggleIsCompleteFor(shoppingItem: item)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }


}
