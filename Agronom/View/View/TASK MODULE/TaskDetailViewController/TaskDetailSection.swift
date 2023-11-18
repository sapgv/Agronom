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
    
    public var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
}

open class TaskOperationRow: TaskSectionRow {

    public override var cellType: UITableViewCell.Type {
        OperationCell.self
    }
    
}

open class TaskFieldRow: TaskSectionRow {

    public override var cellType: UITableViewCell.Type {
        FieldCell.self
    }
    
}

open class TaskVehicleRow: TaskSectionRow {

    public override var cellType: UITableViewCell.Type {
        VehicleCell.self
    }
    
}

open class TaskWorkerRow: TaskSectionRow {

    public override var cellType: UITableViewCell.Type {
        VehicleCell.self
    }
    
}

