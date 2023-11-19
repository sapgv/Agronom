//
//  ToolEditViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import CoreData

final class ToolEditViewModel {
    
    var viewContext: NSManagedObjectContext
    
    var cdItem: CDTool
    
    var sections: [EditSection] = []
    
    var saveCompeltion: ((NSError?) -> Void)? = nil
    
    init(viewContext: NSManagedObjectContext, cdItem: CDTool) {
        self.viewContext = viewContext
        self.cdItem = cdItem
        self.sections = [
            
            EditSection(rows: [
                ToolEditNameRow(),
            ]),
            
        ]
        
    }
    
    func save() {
        
        Model.coreData.save(in: self.viewContext) { [weak self] status in
            
            self?.saveCompeltion?(status.result(CDTool.entityName))
            
        }
        
    }
    
}

class ToolEditNameRow: EditRow {
    
    
}
