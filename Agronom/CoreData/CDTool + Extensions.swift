//
//  CDTool + Extensions.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

extension CDTool {
    
    func fill(item: VehicleTool) {
        self.id = item.id.int16
        self.name = item.name
    }
    
}


