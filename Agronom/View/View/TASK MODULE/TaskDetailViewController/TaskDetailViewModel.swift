//
//  TaskDetailViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import CoreData

final class TaskDetailViewModel {
    
    var viewContext: NSManagedObjectContext
    
    var cdTaskManager: CDTaskManager
    
    var sections: [TaskEditSection] = []
    
    public init(cdTaskManager: CDTaskManager, viewContext: NSManagedObjectContext) {
        self.cdTaskManager = cdTaskManager
        self.viewContext = viewContext
        self.sections = [
            
            TaskEditSection(title: "Задача", rows: [
                TaskFieldRow(),
                TaskOperationRow(),
                TaskVehicleRow(),
                TaskToolRow(),
                TaskWorkerRow()
            ]),
            
            TaskEditSection(title: "Параметры", rows: [
                TaskDepthRow(),
                TaskSpeedRow(),
                TaskLiquidRow(),
            ]),
            
            TaskEditSection(title: "Описание", rows: [
                TaskDescriptionRow(),
            ])
            
        ]
    }
    
}
