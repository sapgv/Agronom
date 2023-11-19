//
//  WorkerEditViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import CoreData

final class WorkerEditViewModel {
    
    var viewContext: NSManagedObjectContext
    
    var cdItem: CDWorker
    
    var sections: [EditSection] = []
    
    var saveCompeltion: ((NSError?) -> Void)? = nil
    
    init(viewContext: NSManagedObjectContext, cdItem: CDWorker) {
        self.viewContext = viewContext
        self.cdItem = cdItem
        self.sections = [
            
            EditSection(rows: [
                WorkerEditNameRow(),
                WorkerEditPositionRow(),
            ]),
            
        ]
        
    }
    
    func save() {
        
        Model.coreData.save(in: self.viewContext) { [weak self] status in
            
            self?.saveCompeltion?(status.result(CDWorker.entityName))
            
        }
        
    }
    
}

class WorkerEditNameRow: EditRow {
    
    
}

class WorkerEditPositionRow: EditRow {
    
    
}
