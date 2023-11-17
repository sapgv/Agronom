//
//  TaskDetailViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

public protocol ITaskDetailViewModel: AnyObject {
    
    associatedtype Section: IAtolSettingSection where Section.Row == Row
    
    associatedtype Row: IAtolSettingsSectionRow
    
    var cdTaskManager: CDTaskManager { get set }
    
    var sections: [Section] { get }
    
}

open class TaskDetailViewModel: ITaskDetailViewModel {

    public typealias Section = AtolSettingsSection
    
    public typealias Row = AtolSettingsRow
    
    open var cdTaskManager: CDTaskManager
    
    open var sections: [Section<Row>] {
        
        var sections: [AtolSettingsSection] = [
            AtolSettingsSection(title: "sdfsf", rows: [
                AtolSettingsDeviceRow(cdAtolDevice: self.cdTaskManager)
            
            ])
        ]
        
        return sections
        
    }
    
    public init(cdTaskManager: CDTaskManager) {
        self.cdTaskManager = cdTaskManager
    }
    
}
