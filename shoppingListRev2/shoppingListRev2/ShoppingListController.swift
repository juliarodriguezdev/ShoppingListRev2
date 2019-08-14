//
//  ShoppingListController.swift
//  shoppingListRev2
//
//  Created by Julia Rodriguez on 8/13/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation
import CoreData

class ShoppingListController {
    
    // singleton
    static let sharedInstance = ShoppingListController()
    
    init() {
        // initialize items from source of truth with fetchItem func
        items = fetchItems()
    }
    // source of truth
    var items: [ShoppingItem] = []
    
    func add(itemWithName item: String) {
        _ = ShoppingItem(item: item)
        saveToPersistentStore()
        items = fetchItems()
        
    }
    
    func remove(shoppingItem: ShoppingItem) {
        shoppingItem.managedObjectContext?.delete(shoppingItem)
        saveToPersistentStore()
        items = fetchItems()
    }
    
    func toggleIsCompleteFor(shoppingItem: ShoppingItem) {
        shoppingItem.isComplete = !shoppingItem.isComplete
        saveToPersistentStore()
        items = fetchItems()
        
    }
    
    private func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving managed object context. Shopping list tems not saved. ")
        }
    }
    
    // call function to populate source of truth from CoreDataStack
    private func fetchItems() -> [ShoppingItem] {
        let request: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
        // if failed to return request return an empty array
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
}
