//
//  ItemController.swift
//  ShoppingList
//
//  Created by Tasuku Yamamoto on 4/15/22.
//

import Foundation

class ItemController{
    //MARK: - Properties
    static let shared = ItemController()
    var shoppingList: [Item] = []
    var alreadyBoughtItems: [Item] = []
    var allLists: [[Item]] = []
    
    //MARK: - CRUD funcs
    func createList(with name: String, quantity: Int){
        let newItem = Item(name: name, quantity: quantity)
        shoppingList.append(newItem)
        saveDataToPersistenceStore()
    }
    
    func updateList(with item: Item){}
    
    func delete(item: Item){
        guard let index = shoppingList.firstIndex(of: item) else { return }
        shoppingList.remove(at: index)
        saveDataToPersistenceStore()
    }
    
    
    //MARK: - Persistence
    //Persistence Store/location of the date
    func persistentStore() -> URL {
        //default is a singelton/shared object of filemanager
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Item.json")
        return fileURL
    }
    
    //Save data
    func saveDataToPersistenceStore() {
        do{
            let data = try JSONEncoder().encode(shoppingList)
            try data.write(to: persistentStore())
        }catch {
            print("We had an error saving to our persistence store")
            print("Encoding Error \(error)")
            print(error.localizedDescription)
        }
    }
    
    //Load data
    func loadDataFromPersistenceStore() {
        do{
            let data = try Data(contentsOf: persistentStore())
            shoppingList = try JSONDecoder().decode([Item].self, from: data)
        }catch{
            print("We had an error loading our data from the persistence store")
            print("Decoding Error \(error)")
            print(error.localizedDescription)
        }
    }
    
}
