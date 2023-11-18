//
//  TitleCell.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(title: String) {
        self.titleLabel.text = title
    }
    
}
