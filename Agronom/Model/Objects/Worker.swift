//
//  Worker.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

final class Worker {
    
    let id: Int
    
    let name: String
    
    let position: String
    
    init(_ data: [String: Any]) {
        self.id = data["id"] as? Int ?? 0
        self.name = data["name"] as? String ?? ""
        self.position = data["position"] as? String ?? ""
    }
    
}
