//
//  CDTaskManager + Extensions.swift
//  AgroFarm
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import Foundation

extension CDTaskManager {

    var solary: Decimal {
        guard let cdField = self.cdField else { return 0 }
        let value = cdField.size * 200
        return Decimal(value)
    }
    
    var cdImages: [CDImage] {
        get {
            self.images_?.array as? [CDImage] ?? []
        }
        set {
            self.images_ = NSOrderedSet(array: newValue)
        }
    }
 
    func fill(item: TaskManager) {
        self.id = item.id.int16
        self.title = item.title
        self.descriptionText = item.description
        self.datetime_planned = item.datetime_planned
        self.datetime_started = item.datetime_started
        self.datetime_completed = item.datetime_completed
        self.odometer_start = item.odometer_start?.int16 ?? 0
        self.odometer_end = item.odometer_end?.int16 ?? 0
        self.report = item.report
    }
    
}

