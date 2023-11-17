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


final class VehicleTool {
    
    let id: Int
    
    let name: String
    
    init(_ data: [String: Any]) {
        self.id = data["id"] as? Int ?? 0
        self.name = data["name"] as? String ?? ""
    }
    
}

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
