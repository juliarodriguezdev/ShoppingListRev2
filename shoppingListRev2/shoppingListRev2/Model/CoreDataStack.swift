//
//  CoreDataStack.swift
//  shoppingListRev2
//
//  Created by Julia Rodriguez on 8/13/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation
class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "shoppingListRev2")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
    
}
