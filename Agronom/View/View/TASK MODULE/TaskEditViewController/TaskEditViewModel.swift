//
//  TaskEditViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import CoreData

class TaskEditViewModel {

    var viewContext: NSManagedObjectContext
    
    var cdTaskManager: CDTaskManager
    
    var sections: [TaskEditSection] = []
    
    var saveCompeltion: ((NSError?) -> Void)? = nil
    
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
    
    func save() {
        
        Model.coreData.save(in: self.viewContext) { [weak self] status in
            
            self?.saveCompeltion?(status.result(CDTaskOperation.entityName))
            
        }
        
    }
    
}
