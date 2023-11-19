//
//  TaskCell.swift
//  Agronom
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var fieldStackView: UIStackView!
    @IBOutlet weak var fieldLabel: UILabel!

    @IBOutlet weak var operationStackView: UIStackView!
    @IBOutlet weak var operationLabel: UILabel!
    
    @IBOutlet weak var vehicleStackView: UIStackView!
    @IBOutlet weak var vehicleLabel: UILabel!
    
    @IBOutlet weak var toolStackView: UIStackView!
    @IBOutlet weak var toolLabel: UILabel!
    
    @IBOutlet weak var workerStackView: UIStackView!
    @IBOutlet weak var workerLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var parameterStackView: UIStackView!
    
    @IBOutlet weak var depthLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var liquidLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(task: CDTaskManager) {
        
        self.fieldLabel.text = task.cdField?.name
        self.fieldStackView.isHidden = (task.cdField?.name ?? "").isEmpty
        
        self.operationLabel.text = task.cdOperation?.name
        self.operationStackView.isHidden = (task.cdOperation?.name ?? "").isEmpty
        
        self.vehicleLabel.text = task.cdVehicle?.name
        self.vehicleStackView.isHidden = (task.cdVehicle?.name ?? "").isEmpty
        
        self.toolLabel.text = task.cdTool?.name
        self.toolStackView.isHidden = (task.cdTool?.name ?? "").isEmpty
        
        self.workerLabel.text = task.cdWorker?.name
        self.workerStackView.isHidden = (task.cdWorker?.name ?? "").isEmpty
        
        self.descriptionLabel.text = task.descriptionText
        self.descriptionLabel.isHidden = task.descriptionText.isEmpty
        
        self.depthLabel.text = "Глубина см \(task.depth)"
        self.depthLabel.isHidden = task.depth == 0
        
        self.speedLabel.text = "Рабочая скорость \(task.speed)"
        self.speedLabel.isHidden = task.speed == 0

        self.liquidLabel.text = "Расход рабочего раствора л/га \(task.liquid)"
        self.liquidLabel.isHidden = task.liquid == 0
        
        self.parameterStackView.isHidden = (depthLabel.isHidden
                                             && speedLabel.isHidden
                                             && liquidLabel.isHidden)
        
        
        
    }

    
}
