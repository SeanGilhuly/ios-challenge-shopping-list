//
//  ButtonTableViewCell.swift
//  ShoppingList
//
//  Created by Sean Gilhuly on 5/20/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var itemLabelText: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    //MARK: - IBActions
    
    @IBAction func buttonTapped(sender: AnyObject) {
        // Is this where the UIAlert goes?
    }
    
    
    func updateButton(isComplete: Bool) {
        if isComplete {
            isCompleteButton.setImage(UIImage(named: "complete"), forState: .Normal)
        } else {
            isCompleteButton.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }

}