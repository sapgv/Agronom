//
//  TaskOperation.swift
//  Agronom
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import Foundation

final class TaskOperation {
    
    let id: Int
    
    let name: String
    
    let description: String
    
    init(_ data: [String: Any]) {
        self.id = data["id"] as? Int ?? 0
        self.name = data["name"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
    }
    
}

