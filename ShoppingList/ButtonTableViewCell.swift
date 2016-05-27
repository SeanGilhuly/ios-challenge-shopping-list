//
//  ButtonTableViewCell.swift
//  ShoppingList
//
//  Created by Sean Gilhuly on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - IBActions
    
    @IBAction func buttonTapped(sender: AnyObject) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    // MARK: - Functions
    
    func updateWithItem(item: Item) {
        nameLabel.text = item.name
        itemDescriptionLabel.text = item.itemDescription
        updateButton(item.isComplete.boolValue)
    }
    
    func updateButton(isComplete: Bool) {
        if isComplete {
            isCompleteButton.setImage(UIImage(named: "complete"), forState: .Normal)
        } else {
            isCompleteButton.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }
}

// MARK: - Protocol

protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(cell: ButtonTableViewCell)
}