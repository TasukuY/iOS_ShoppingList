//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Tasuku Yamamoto on 4/15/22.
//

import UIKit

protocol itemBoughtDelegate: AnyObject{
    func boughtItem(in cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    
    //MARK: - Properties
    weak var delegate: itemBoughtDelegate?
    var item: Item? {
        didSet{
            updateViews()
        }
    }
    
    //MARK: - IBActions
    @IBAction func checkBoxTapped(_ sender: Any) {
        print("check Box Tapped")
        delegate?.boughtItem(in: self)
    }
    
    func updateViews(){
        print("updateView Called")
        guard let item = item else {
            print("no item")
            return
        }
        itemLabel.text = "\(item.name) x \(item.quantity)"
        checkBox.setImage(item.isBought ? UIImage(systemName: "checkmark.square")?.withTintColor(.black, renderingMode: .alwaysOriginal) : UIImage(systemName: "square")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
    }

}//End of class
