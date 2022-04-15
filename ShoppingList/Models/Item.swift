//
//  Item.swift
//  ShoppingList
//
//  Created by Tasuku Yamamoto on 4/15/22.
//

import Foundation

class Item: Codable {
    //MARK: - Properties
    var name: String
    var quantity: Int
    var isBought: Bool
    
    //MARK: - Initializer
    init(name: String, quantity: Int){
        self.name = name
        self.quantity = quantity
        self.isBought = false
    }
    
}//End of class

extension Item: Equatable{
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.quantity == rhs.quantity && lhs.isBought == rhs.isBought
    }
}
