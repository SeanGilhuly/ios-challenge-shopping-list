//
//  Item.swift
//  ShoppingList
//
//  Created by Sean Gilhuly on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject {
    
    convenience init?(name: String, itemDescription: String, isComplete: Bool = false, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context) else {return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.itemDescription = itemDescription
        self.isComplete = isComplete
    }
}