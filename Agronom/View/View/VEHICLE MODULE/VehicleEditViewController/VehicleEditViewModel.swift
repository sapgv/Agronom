//
//  VehicleEditViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 19.11.2023.
//

import CoreData

final class VehicleEditViewModel {
    
    var viewContext: NSManagedObjectContext
    
    var cdItem: CDVehicle
    
    var sections: [EditSection] = []
    
    var saveCompeltion: ((NSError?) -> Void)? = nil
    
    init(viewContext: NSManagedObjectContext, cdItem: CDVehicle) {
        self.viewContext = viewContext
        self.cdItem = cdItem
        self.sections = [
            
            EditSection(rows: [
                VehicleEditNameRow(),
            ]),
            
        ]
        
    }
    
    func save() {
        
        Model.coreData.save(in: self.viewContext) { [weak self] status in
            
            self?.saveCompeltion?(status.result(CDVehicle.entityName))
            
        }
        
    }
    
}

class VehicleEditNameRow: EditRow {
    
    
}
