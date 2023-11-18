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
    
    @IBOutlet weak var workerLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var depthLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var liquidLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(task: CDTaskManager) {
        
        self.operationLabel.text = task.cdOperation?.name
        self.operationLabel.isHidden = (task.cdOperation?.name ?? "").isEmpty
        
        self.fieldLabel.text = task.cdField?.name
        self.fieldLabel.isHidden = (task.cdField?.name ?? "").isEmpty
        
        self.vehicleLabel.text = task.cdVehicle?.name
        self.vehicleLabel.isHidden = (task.cdVehicle?.name ?? "").isEmpty
        
        self.workerLabel.text = task.cdWorker?.name
        self.workerLabel.isHidden = (task.cdWorker?.name ?? "").isEmpty
        
        self.descriptionLabel.text = task.descriptionText
        self.descriptionLabel.isHidden = task.descriptionText.isEmpty
        
        self.depthLabel.text = "Глубина см \(task.depth)"
        self.depthLabel.isHidden = task.depth == 0
        
        self.speedLabel.text = "Рабочая скорость \(task.speed)"
        self.speedLabel.isHidden = task.speed == 0
        
        self.liquidLabel.text = "Расход рабочего раствора л/га \(task.liquid)"
        self.liquidLabel.isHidden = task.liquid == 0
        
    }

    
}
