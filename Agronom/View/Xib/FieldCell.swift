//
//  FieldCell.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

class FieldCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plantedLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(item: CDField) {
        self.titleLabel.text = item.name
        self.plantedLabel.text = item.planted
        self.plantedLabel.isHidden = item.planted.isEmpty
        self.sizeLabel.text = "\(item.size) Га"
    }
    
}
