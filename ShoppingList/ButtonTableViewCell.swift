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
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
    
    func updateButton(isIncomplete: Bool) {
        if isIncomplete {
            isCompleteButton.setImage(UIImage(named: "incomplete"), forState: .Normal)
        } else {
            isCompleteButton.setImage(UIImage(named: "complete"), forState: .Normal)
        }
    }
}

// MARK: - Protocol

protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(cell: ButtonTableViewCell)
}
