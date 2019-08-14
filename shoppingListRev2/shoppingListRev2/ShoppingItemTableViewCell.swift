//
//  ShoppingItemTableViewCell.swift
//  shoppingListRev2
//
//  Created by Julia Rodriguez on 8/13/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class ShoppingItemTableViewCell: UITableViewCell {

    @IBOutlet weak var groceryItemLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    var delegate: ShoppingItemTableViewCellDelegate?
    
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        // call delegate to call func shoppingItemTapped()
        delegate?.shoppingItemTapped(self)
    }
    
    fileprivate func updateButton(_ isComplete: Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        isCompleteButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func update(item: ShoppingItem) {
        groceryItemLabel.text = item.name
        updateButton(item.isComplete)
    }
    
}

protocol ShoppingItemTableViewCellDelegate {
    // method signature, to assing delegate to execute task
    func shoppingItemTapped(_ sender: ShoppingItemTableViewCell)
}
