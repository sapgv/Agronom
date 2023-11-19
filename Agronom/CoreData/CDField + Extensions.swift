//
//  CDField + Extensions.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

extension CDField {
    
    func fill(item: Field) {
        self.id = item.id.int16
        self.name = item.name
        self.size = item.size.int64
        self.planted = item.planted
    }
    
}

