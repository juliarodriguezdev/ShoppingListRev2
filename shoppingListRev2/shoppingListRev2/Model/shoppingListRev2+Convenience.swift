//
//  shoppingListRev2+Convenience.swift
//  shoppingListRev2
//
//  Created by Julia Rodriguez on 8/13/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation
import CoreData

extension ShoppingItem {
    
    convenience init(item: String, isComplete: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = item
        self.isComplete = isComplete
    }
}
