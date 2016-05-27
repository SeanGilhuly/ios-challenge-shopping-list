//
//  ItemListTableViewController.swift
//  ShoppingList
//
//  Created by Sean Gilhuly on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class ItemListTableViewController: UITableViewController, ButtonTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        ItemController.sharedController.fetchedResultsController.delegate = self
    }
    
    // MARK: - IBAction
    
    @IBAction func addItem(sender: AnyObject) {
        addItemAlert()
    }
    
    // MARK: - ButtonTableViewCellDelegate
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPathForCell(sender),
            task = ItemController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Item else {
                return
        }
        ItemController.sharedController.isCompleteValueToggle(task)
    }

    
    //MARK: - Alert Controller
    
    func addItemAlert() {
        
        var nameTextField: UITextField?
        var itemDescriptionTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add New Item", message: "Please add a new item", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Item name"
            nameTextField = textField
        }
        alertController.addTextFieldWithConfigurationHandler { (aTextField) in
            aTextField.placeholder = "Item Description"
            itemDescriptionTextField = aTextField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let createAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            guard let name = nameTextField?.text, itemDescription = itemDescriptionTextField?.text where name.characters.count > 0 && itemDescription.characters.count > 0 else { return }
            ItemController.sharedController.addItem(name, itemDescription: itemDescription)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sections = ItemController.sharedController.fetchedResultsController.sections else {
            return 0
        }
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = ItemController.sharedController.fetchedResultsController.sections else {
            return 0
        }
        return sections[section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as? ButtonTableViewCell ?? ButtonTableViewCell()

        // Configure the cell...
        guard let item = ItemController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Item else {
            return UITableViewCell()
        }
        cell.updateWithItem(item)
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = ItemController.sharedController.fetchedResultsController.sections,
            index = Int(sections[section].name) else {
                return nil
        }
        if index == 0 {
            return "Incomplete"
        } else {
            return "Complete"
        }
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            guard let item = ItemController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Item else {
                return
            }
            ItemController.sharedController.removeItem(item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}


extension ItemListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case.Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath, newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}


