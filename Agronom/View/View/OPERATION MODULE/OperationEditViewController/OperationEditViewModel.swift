//
//  OperationEditViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import CoreData

final class OperationEditViewModel {
    
    var viewContext: NSManagedObjectContext
    
    var cdItem: CDTaskOperation
    
    var sections: [EditSection] = []
    
    var saveCompeltion: ((NSError?) -> Void)? = nil
    
    init(viewContext: NSManagedObjectContext, cdItem: CDTaskOperation) {
        self.viewContext = viewContext
        self.cdItem = cdItem
        self.sections = [
            
            EditSection(rows: [
                OperationEditNameRow(),
                OperationEditDescriptionRow()
            ]),
            
        ]
        
    }
    
    func save() {
        
        Model.coreData.save(in: self.viewContext) { [weak self] status in
            
            self?.saveCompeltion?(status.result(CDTaskOperation.entityName))
            
        }
        
    }
    
}

class OperationEditNameRow: EditRow {
    
    
}

class OperationEditDescriptionRow: EditRow {
    
    
}
