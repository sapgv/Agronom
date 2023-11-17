//
//  CDTaskOperation + Extensions.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

extension CDTaskOperation {
    
    func fill(item: TaskOperation) {
        self.id = item.id.int16
        self.name = item.name
        self.descriptionText = item.description
    }
    
}

