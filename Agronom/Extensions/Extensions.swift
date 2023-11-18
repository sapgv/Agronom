//
//  Extensions.swift
//  Agronom
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import UIKit
import CoreData

public extension Thread {
    class func run(execute: @escaping @convention(block) () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async(execute: execute)
    }
    
    class func run(execute: DispatchWorkItem) {
        DispatchQueue.global(qos: .userInitiated).async(execute: execute)
    }
    
    class func main(execute: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.async(execute: execute)
    }
    
    class func main(execute: DispatchWorkItem) {
        DispatchQueue.main.async(execute: execute)
    }
    
}

extension String {
    
    static var unique: String {
        return UUID().uuidString
    }
    
    var int: Int? {
        Int(self)
    }
    
}

extension Error {
    
    var NSError: Foundation.NSError {
        return Foundation.NSError(domain: "App.NSError", code: 0, userInfo: [NSLocalizedDescriptionKey: self.localizedDescription])
    }
    
}

extension Date {
    
    func format(formatt: String = "dd MMM yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatt
        let value = dateFormatter.string(from: self)
        return value
    }
    
}

extension Int {
    
    var int16: Int16 {
        Int16(self)
    }
    
}

extension Dictionary where Key == String, Value == Any {
    
    func date(key: String) -> Date? {
        
        let dateString = self[key] as? String ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateString)
        return date
        
    }
    
}

extension Optional where Wrapped == String {
    
    var clean: String {
        self ?? ""
    }
    
    func defaultValue(value: String) -> String {
        guard let self = self else { return value }
        return self.isEmpty ? value : self
    }
    
    var isEmpty: Bool {
        guard let self = self else { return true }
        return self.isEmpty
    }
    
}

extension UINavigationBar {
    
    static func restoreAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
}

extension UITabBar {
    
    static func restoreAppearance() {
        let appearance = UITabBarAppearance()
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
}

extension UITableView {
    
    static func restoreAppearance() {
        UITableView.appearance().sectionHeaderTopPadding = 0.0
    }
    
}

extension NSManagedObjectContext {
    
    func objectInContext<T: NSManagedObject>(_ type: T.Type, objectID: NSManagedObjectID?) -> T? {
        guard let objectID = objectID else { return nil }
        return self.object(with: objectID) as? T
    }
    
}
