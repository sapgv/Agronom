//
//  TaskManager.swift
//  AgroFarm
//
//  Created by Grigory Sapogov on 15.11.2023.
//

import Foundation
import UIKit
import SwiftUI

final class TaskManager: Identifiable, ObservableObject {
    
    let id: Int
    
    let title: String
    
    let description: String
    
    let datetime_planned: Date
    
    let datetime_started: Date?
    
    let datetime_completed: Date?
    
    let odometer_start: Int?
    
    let odometer_end: Int?
    
    let report: String?
    
    let vehicle: Vehicle?
    
    let operation: TaskOperation?
    
    let worker: Worker?
    
    let field: Field?
    
    var images: [UIImage] = []
    
    init(_ data: [String: Any]) {
        self.id = data["id"] as? Int ?? Int.random(in: 0...Int.max)
        self.title = data["title"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.datetime_planned = data.date(key: "datetime_planned") ?? Date()
        self.datetime_started = data.date(key: "datetime_started")
        self.datetime_completed = data.date(key: "datetime_completed")
        self.odometer_start = data["odometer_start"] as? Int
        self.odometer_end = data["odometer_start"] as? Int
        self.report = data["report"] as? String
        
        if let data = data["operation"] as? [String: Any] {
            self.operation = TaskOperation(data)
        }
        else {
            self.operation = nil
        }
        
        if let data = data["vehicle"] as? [String: Any] {
            self.vehicle = Vehicle(data)
        }
        else {
            self.vehicle = nil
        }
        
        if let data = data["worker"] as? [String: Any] {
            self.worker = Worker(data)
        }
        else {
            self.worker = nil
        }
        
        if let data = data["field"] as? [String: Any] {
            self.field = Field(data)
        }
        else {
            self.field = nil
        }
        
    }
    
}


extension TaskManager {
    
    var finished: Bool {
        self.datetime_completed != nil
    }
    
    var status: String {
        self.finished ? "Выполнено" : "Не выполнено"
    }
    
    var statusColor: Color {
        self.finished ? .green : .red
    }
    
}



