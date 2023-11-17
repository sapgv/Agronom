//
//  OperationCell.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

class OperationCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(item: CDTaskOperation) {
        self.titleLabel.text = item.name
        self.descriptionLabel.text = item.descriptionText
        
        
    }
    
    
}
