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
    
    @Published var images: [UIImage] = []
    
    init(id: Int,
         title: String,
         description: String,
         vehicle: Vehicle? = nil,
         datetime_planned: Date,
         datetime_started: Date? = nil,
         datetime_completed: Date? = nil,
         odometer_start: Int? = nil,
         odometer_end: Int? = nil,
         report: String? = nil,
         images: [UIImage] = []) {
        self.id = id
        self.title = title
        self.description = description
        self.vehicle = vehicle
        self.datetime_planned = datetime_planned
        self.datetime_started = datetime_started
        self.datetime_completed = datetime_completed
        self.odometer_start = odometer_start
        self.odometer_end = odometer_end
        self.report = report
        self.images = images
    }
    
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
        self.vehicle = nil
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



extension TaskManager {
    
    static var data: [[String: Any]] {
        
        let array = (1...5).map { i in
            
            return [
                "id": "\(i)",
                "operation": "Операция номер \(i)",
                "vehicle": "Транспорт номер \(i)",
                "text": "Описание номер \(i)",
                "date": Date().ISO8601Format(),
                "finished": false
            ]
            
        }
        
        return array
        
    }
    
}

extension TaskManager {
    
    static var randomTaskImages: [UIImage] {
        
        let images = [
            UIImage(named: "nature1")!,
            UIImage(named: "nature2")!,
            UIImage(named: "nature3")!,
            UIImage(named: "nature4")!,
            UIImage(named: "nature2")!,
            UIImage(named: "nature3")!,
        ]
        
        return images
        
    }
    
    static var randomTaskPreview: TaskManager {
        
        return TaskManager(id: Int.random(in: 0...Int.max), title: "Заголовок задачи", description: "Описание задачи", vehicle: nil, datetime_planned: Date(), datetime_started: Date(), datetime_completed: Date(), odometer_start: 1000, odometer_end: 2000, report: "Отчет о завершении", images: randomTaskImages)
        
    }
    
}
