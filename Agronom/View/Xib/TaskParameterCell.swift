//
//  TaskParameterCell.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

class TaskParameterCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    var textChanged: ((String?) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }

    @objc
    private func editingChanged() {
        self.textChanged?(self.textField.text)
    }
    
}
