//
//  SolaryCell.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import UIKit

class SolaryCell: UITableViewCell {

    @IBOutlet weak var fieldLabel: UILabel!
    
    @IBOutlet weak var operationLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(item: CDTaskManager) {
        
        self.fieldLabel.text = item.cdField?.name
        self.operationLabel.text = item.cdOperation?.name
        self.valueLabel.text = "\(item.solary) Руб"
        
    }
    
}
