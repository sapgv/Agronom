//
//  CDWorker + Extensions.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

extension CDWorker {
    
    func fill(item: Worker) {
        self.id = item.id.int16
        self.name = item.name
        self.position = item.position
    }
    
}

