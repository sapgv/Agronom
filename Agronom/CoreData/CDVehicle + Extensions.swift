//
//  CDVehicle + Extensions.swift
//  AgroFarm
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import Foundation

extension CDVehicle {
    
    func fill(item: Vehicle) {
        self.id = item.id.int16
        self.name = item.name
    }
    
}
