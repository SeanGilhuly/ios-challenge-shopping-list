//
//  Shopping.swift
//  ShoppingList
//
//  Created by Sean Gilhuly on 5/20/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Shopping: NSManagedObject {

    
    convenience init(name: String, iscomplete: Bool = false, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.isComplete = false
    }
}
