//
//  TaskMechanic.swift
//  AgroFarm
//
//  Created by Grigory Sapogov on 16.11.2023.
//

import Foundation

import Foundation
import UIKit
import SwiftUI

final class TaskMechanic: Identifiable, ObservableObject {

    let id: String
    
    var title: String?
    
    var dateStart: Date?
    
    var dateEnd: Date?
    
    init(id: String = String.unique,
         title: String? = nil,
         dateStart: Date? = nil,
         dateEnd: Date? = nil) {
        self.id = id
        self.title = title
        self.dateStart = dateStart
        self.dateEnd = dateEnd
    }
    
}

extension TaskMechanic {
    
    var hours: String {
        guard let dateStart = dateStart else { return "" }
        guard let dateEnd = dateEnd else { return "" }
        guard dateEnd > dateStart else { return "" }
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: dateStart, to: dateEnd)
        let hours = diffComponents.hour ?? 0
        let minutes = diffComponents.minute ?? 0
        let hoursText = hours > 0 ? "\(hours) ч" : ""
        let minutesText = minutes > 0 ? "\(minutes) мин" : ""
        return "\(hoursText) \(minutesText)"
    }
    
}

extension TaskMechanic {
    
    static var ranomArray: [TaskMechanic] {
        
        (1...10).map { _ in
            
            return TaskMechanic(title: "Ремонт техники \(String.unique)", dateStart: Date().addingTimeInterval(-7200), dateEnd: Date())
            
        }
        
        
    }
    
}
