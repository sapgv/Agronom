//
//  StartCheckListEditViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import CoreData

final class StartCheckListEditViewModel {
    
    var viewContext: NSManagedObjectContext
    
    var cdItem: CDTaskManager
    
    var sections: [EditSection] = []
    
    var saveCompeltion: ((NSError?) -> Void)? = nil
    
    init(viewContext: NSManagedObjectContext, cdItem: CDTaskManager) {
        self.viewContext = viewContext
        self.cdItem = cdItem
        self.sections = [
            
            EditSection(rows: [
                CheckListOdometrRow(),
                CheckListLiquidRow(),
            ]),
            
        ]
        
    }
    
    func save() {
        
        self.cdItem.datetime_started = Date()
        
        Model.coreData.save(in: self.viewContext) { [weak self] status in

            self?.saveCompeltion?(status.result(CDTaskManager.entityName))

        }
        
    }
    
}

class CheckListOdometrRow: EditRow {


}

class CheckListLiquidRow: EditRow {


}

