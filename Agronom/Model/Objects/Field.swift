//
//  Field.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

final class Field {
    
    let id: Int
    
    let name: String
    
    let size: Int
    
    let planted: String
    
    init(_ data: [String: Any]) {
        self.id = data["id"] as? Int ?? 0
        self.name = data["name"] as? String ?? ""
        self.size = data["size"] as? Int ?? 0
        self.planted = data["planted"] as? String ?? ""
    }
    
}

