//
//  TaskDetailSection.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import UIKit

public protocol IAtolSettingSection: AnyObject {
    
    associatedtype Row: IAtolSettingsSectionRow
    
    var title: String { get }
    
    var rows: [Row] { get }
    
}

open class AtolSettingsSection<Row: IAtolSettingsSectionRow>: IAtolSettingSection {

    public let title: String
    
    public let rows: [Row]
    
    public required init(title: String, rows: [Row] = []) {
        self.title = title
        self.rows = rows
    }
    
}

public protocol IAtolSettingsSectionRow: AnyObject {
    
    var cdAtolDevice: CDTaskManager? { get }
    
    var cellType: UITableViewCell.Type { get }
    
    init(cdAtolDevice: CDTaskManager?)
    
}

open class AtolSettingsRow: IAtolSettingsSectionRow {
    
    public let cdAtolDevice: CDTaskManager?
    
    public var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
    public required init(cdAtolDevice: CDTaskManager?) {
        self.cdAtolDevice = cdAtolDevice
    }
    
}

open class AtolSettingsDeviceRow: AtolSettingsRow {

    public override var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
}

open class AtolSettingsButtonRow: AtolSettingsRow {
    
    public override var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
}

open class AtolSettingsEditRow: AtolSettingsRow {
    
    public override var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
}

open class AtolSettingsReportRow: AtolSettingsRow {
    
    public override var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
}

open class AtolSettingsShiftRow: AtolSettingsRow {
    
    public override var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
}

open class AtolSettingsCashRow: AtolSettingsRow {
    
    public override var cellType: UITableViewCell.Type {
        UITableViewCell.self
    }
    
}
