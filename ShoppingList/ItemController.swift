//
//  ItemController.swift
//  ShoppingList
//
//  Created by Sean Gilhuly on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    //MARK: - Singleton
    
    static let sharedController = ItemController()
    
    //MARK: - Properties and Initializors
    
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        let request = NSFetchRequest(entityName: "Item")
        let completedSortDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        let dueSortDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        request.sortDescriptors = [completedSortDescriptor, dueSortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Unable to perform fetch request")
        }
    }
    
    //MARK: - Functions CRUD
    
    func addItem(name: String, itemDescription: String?) {
        _ = Item(name: name, itemDescription: itemDescription)
        saveToPersistentStore()
    }
    
    func removeItem(item: Item) {
        if let moc = item.managedObjectContext {
            moc.deleteObject(item)
            saveToPersistentStore()
        }
    }
    
    func updateItem(item: Item, name: String, itemDescription: String?, isComplete: Bool) {
        item.name = name
        item.itemDescription = itemDescription
        item.isComplete = isComplete
        saveToPersistentStore()
    }
    
    func isCompleteValueToggle(item: Item) {
        item.isComplete = !item.isComplete.boolValue
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
           print("Failed to save to presistent storage \(#file) \(#function) \(#line)")
        }
    }
}