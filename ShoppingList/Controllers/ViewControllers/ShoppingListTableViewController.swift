//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Tasuku Yamamoto on 4/15/22.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.loadDataFromPersistenceStore()
    }

    //MARK: - IBActions
    @IBAction func addItemButtonTapped(_ sender: Any) {
        presentAddItemAlert()
    }
    
    //MARK: - Alert Methods
    func presentAddItemAlert(){
        let addItemAlert = UIAlertController(title: "Add an Item", message: "Please type the name and the quantity", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            print("Cancel option selected by user")
        }
        let addItemAction = UIAlertAction(title: "Add", style: .cancel) { _ in
            let itemNameTextField = addItemAlert.textFields![0] as UITextField
            let quantityTextField = addItemAlert.textFields![1] as UITextField
            guard let itemName = itemNameTextField.text,
                  let quantityString = quantityTextField.text,
                  let quantity = Int(quantityString) else { return }
            ItemController.shared.createList(with: itemName, quantity: quantity)
            self.tableView.reloadData()
        }
        [cancelAction, addItemAction].forEach{addItemAlert.addAction($0)}
        addItemAlert.addTextField { (textField) in
            textField.placeholder = "Item name"
        }
        
        addItemAlert.addTextField { (textField) in
            textField.placeholder = "Item quantity"
        }

        present(addItemAlert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell()}
        cell.delegate = self
        let item = ItemController.shared.shoppingList[indexPath.row]
        cell.itemLabel.text = "\(item.name) x \(item.quantity)"
        cell.checkBox.setImage(item.isBought ? UIImage(systemName: "checkmark.square")?.withTintColor(.black, renderingMode: .alwaysOriginal) : UIImage(systemName: "square")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        cell.item = item
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = ItemController.shared.shoppingList[indexPath.row]
            ItemController.shared.delete(item: itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}//End of class

extension ShoppingListTableViewController: itemBoughtDelegate{
    func boughtItem(in cell: ItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = ItemController.shared.shoppingList[indexPath.row]
        ItemController.shared.bought(item: item)
        cell.updateViews()
    }
}
