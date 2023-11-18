//
//  MainViewSection.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

final class MainSection {
    
    let title: String
    
    var rows: [MainSectionRow] = []
    
    init(title: String, rows: [MainSectionRow]) {
        self.title = title
        self.rows = rows
    }
    
}

class MainSectionRow {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
}

class TaskRow: MainSectionRow {
    
    override init(title: String = "Задачи") {
        super.init(title: title)
    }
    
}


class OperationRow: MainSectionRow {
    
    override init(title: String = "Операции") {
        super.init(title: title)
    }
    
}

class VehicleRow: MainSectionRow {
    
    override init(title: String = "Механика") {
        super.init(title: title)
    }
    
}

class ToolRow: MainSectionRow {
    
    override init(title: String = "Оборудование") {
        super.init(title: title)
    }
    
}

class FieldRow: MainSectionRow {
    
    override init(title: String = "Поля") {
        super.init(title: title)
    }
    
}

class WorkerRow: MainSectionRow {
    
    override init(title: String = "Работники") {
        super.init(title: title)
    }
    
}
