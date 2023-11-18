//
//  TaskDetailViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

open class TaskDetailViewModel {

    open var cdTaskManager: CDTaskManager
    
    open var sections: [TaskSection] {
        
        var sections: [TaskSection] = [
            TaskSection(title: "sdfsf", rows: [
                TaskOperationRow()
            
            ])
        ]
        
        return sections
        
    }
    
    public init(cdTaskManager: CDTaskManager) {
        self.cdTaskManager = cdTaskManager
    }
    
}
