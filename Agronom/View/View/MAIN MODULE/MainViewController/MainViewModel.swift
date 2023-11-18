//
//  MainViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

final class MainViewModel {
    
    var sections: [MainSection] = []
    
    init(sections: [MainSection] = []) {
        
        self.sections = [
            
            MainSection(title: "Документы", rows: [
                TaskRow()
            ]),
            
            MainSection(title: "Справочники", rows: [
                OperationRow(),
                VehicleRow(),
                ToolRow(),
                FieldRow(),
                WorkerRow()
            ])
        
        ]
        
    }
    
    
    
}
