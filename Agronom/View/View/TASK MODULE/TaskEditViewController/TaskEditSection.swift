//
//  TaskEditSection.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

class TaskEditSection {

    public let title: String
    
    public let rows: [TaskSectionRow]
    
    public required init(title: String, rows: [TaskSectionRow] = []) {
        self.title = title
        self.rows = rows
    }
    
}

class TaskSectionRow {
    
}

class TaskOperationRow: TaskSectionRow {

    
}

class TaskFieldRow: TaskSectionRow {

    
}

class TaskVehicleRow: TaskSectionRow {

    
}

class TaskToolRow: TaskSectionRow {

    
}

class TaskWorkerRow: TaskSectionRow {

    
}

class TaskDepthRow: TaskSectionRow {
    
    
}

class TaskSpeedRow: TaskSectionRow {
    
    
}

class TaskLiquidRow: TaskSectionRow {
    
    
}

class TaskDescriptionRow: TaskSectionRow {
    
    
}
