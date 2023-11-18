//
//  TaskDetailViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import CoreData

open class TaskDetailViewModel {

    open var viewContext: NSManagedObjectContext
    
    open var cdTaskManager: CDTaskManager
    
    open var sections: [TaskSection] {
        
        let sections: [TaskSection] = [
            TaskSection(title: "Задача", rows: [
                TaskOperationRow(),
                TaskFieldRow(),
                TaskVehicleRow(),
                TaskWorkerRow()
            ])
        ]
        
        return sections
        
    }
    
    public init(cdTaskManager: CDTaskManager, viewContext: NSManagedObjectContext) {
        self.cdTaskManager = cdTaskManager
        self.viewContext = viewContext
    }
    
}
