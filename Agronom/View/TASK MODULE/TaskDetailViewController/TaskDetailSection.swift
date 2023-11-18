//
//  TaskDetailSection.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

open class TaskSection {

    public let title: String
    
    public let rows: [TaskSectionRow]
    
    public required init(title: String, rows: [TaskSectionRow] = []) {
        self.title = title
        self.rows = rows
    }
    
}

open class TaskSectionRow {
    
//    public let cdAtolDevice: CDTaskManager?
    
    public var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
//    public required init(cdAtolDevice: CDTaskManager?) {
//        self.cdAtolDevice = cdAtolDevice
//    }
    
}

open class TaskOperationRow: TaskSectionRow {

    public override var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
}

