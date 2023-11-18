//
//  TaskCell.swift
//  Agronom
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var operationLabel: UILabel!
    
    @IBOutlet weak var fieldLabel: UILabel!
    
    @IBOutlet weak var vehicleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(task: CDTaskManager) {
        self.operationLabel.text = task.cdOperation?.name
        self.fieldLabel.text = task.cdField?.name
        self.vehicleLabel.text = task.cdVehicle?.name
        self.descriptionLabel.text = task.descriptionText.defaultValue(value: "Описание задачи")
    }

    
}
