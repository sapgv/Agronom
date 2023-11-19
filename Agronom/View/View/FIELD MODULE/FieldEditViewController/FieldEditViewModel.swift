//
//  FieldEditViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import CoreData

final class FieldEditViewModel {
    
    var viewContext: NSManagedObjectContext
    
    var cdItem: CDField
    
    var sections: [EditSection] = []
    
    var saveCompeltion: ((NSError?) -> Void)? = nil
    
    init(viewContext: NSManagedObjectContext, cdItem: CDField) {
        self.viewContext = viewContext
        self.cdItem = cdItem
        self.sections = [
            
            EditSection(rows: [
                FieldEditNameRow(),
                FieldEditPlantedRow(),
                FieldEditSizeRow(),
            ]),
            
        ]
        
    }
    
    func save() {
        
        Model.coreData.save(in: self.viewContext) { [weak self] status in
            
            self?.saveCompeltion?(status.result(CDField.entityName))
            
        }
        
    }
    
}

class FieldEditNameRow: EditRow {
    
    
}

class FieldEditPlantedRow: EditRow {
    
    
}

class FieldEditSizeRow: EditRow {
    
    
}
