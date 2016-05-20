//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Sean Gilhuly on 5/20/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit


class ShoppingListTableViewController: UITableViewController {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:  IBActions
    
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        let alertController = UIAlertController(title: "New Item", message: "Add new item", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Item name"
        }
        let createAction = UIAlertAction(title: "Create", style: .Default) { (_) in
            guard let textFields = alertController.textFields,
                firstTextField = textFields.first,
                itemName = firstTextField.text else {
                    return
            }
            ShoppingController.sharedController.addItem(itemName)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func updateButton(isComplete: Bool) {
        if isComplete {
            isCompleteButton.setImage(UIImage(named: "complete"), forState: .Normal)
        } else {
            isCompleteButton.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }

    

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ShoppingController.sharedController.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("addItem", forIndexPath: indexPath)

        // Configure the cell...
        
        let item = ShoppingController.sharedController.items[indexPath.row]
        cell.textLabel?.text = item.name

        return cell
    }

   
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            let item = ShoppingController.sharedController.items[indexPath.row]
            ShoppingController.sharedController.deleteItem(item)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
