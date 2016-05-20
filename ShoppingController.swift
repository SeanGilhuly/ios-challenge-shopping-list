//
//  ShoppingController.swift
//  ShoppingList
//
//  Created by Sean Gilhuly on 5/20/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class ShoppingController {
    
    static let sharedController = ShoppingController()
    
    var items = [Shopping]()
    
    func addItem(name: String) {
        let item = Shopping(name: name)
        items.append(item)
    }
    
    func deleteItem(item: Shopping) {
        guard let indexOfItems = items.indexOf(item) else {
            return
        }
        items.removeAtIndex(indexOfItems)
    }

}

