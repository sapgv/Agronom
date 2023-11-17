//
//  Model.swift
//  Agronom
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import Foundation

final class Model {
    
    static var coreData: CoreData!
    
    static func define() {
        
        self.coreData = CoreData(model: "Agronom")
        
    }
    
}
