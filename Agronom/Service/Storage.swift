//
//  Storage.swift
//  AgroFarm
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import CoreData

enum StorageError: Error {
    case saveFailure(String)
}

public extension NSManagedObject {
    
    static var entityName: String {
        return String(describing: self)
    }
    
}

final class Storage {
    
    func save(array: [TaskManager], completion: @escaping (NSError?) -> Void) {
        
        Model.coreData.backgroundTask { privateContext in
            
            privateContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
            for item in array {
                
                let cdTaskManager = CDTaskManager(context: privateContext)
                cdTaskManager.fill(item: item)
                
                cdTaskManager.cdOperation = self.createOperation(item.operation, inContext: privateContext)
                cdTaskManager.cdField = self.createField(item.field, inContext: privateContext)
                cdTaskManager.cdWorker = self.createWorker(item.worker, inContext: privateContext)
                cdTaskManager.cdVehicle = self.createVehicle(item.vehicle, inContext: privateContext)
                
            }
            
            Model.coreData.save(in: privateContext) { status in
                
                Thread.main {
                    completion(status.result(CDTaskManager.entityName)?.NSError)
                }
                
            }
            
        }
            
    }
    
    func save(array: [Vehicle], completion: @escaping (NSError?) -> Void) {
        
        Model.coreData.backgroundTask { privateContext in
            
            privateContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
            for item in array {
                
                let cdVehicle = CDVehicle(context: privateContext)
                cdVehicle.fill(item: item)
                
            }
            
            Model.coreData.save(in: privateContext) { status in
                
                Thread.main {
                    completion(status.result(CDVehicle.entityName)?.NSError)
                }
                
            }
            
        }
        
    }
    
    func save(array: [TaskOperation], completion: @escaping (NSError?) -> Void) {
        
        Model.coreData.backgroundTask { privateContext in
            
            privateContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
            for item in array {
                
                let cdTaskOperation = CDTaskOperation(context: privateContext)
                cdTaskOperation.fill(item: item)
                
            }
            
            Model.coreData.save(in: privateContext) { status in
                
                Thread.main {
                    completion(status.result(CDVehicle.entityName)?.NSError)
                }
                
            }
            
        }
        
    }
    
    func save(array: [VehicleTool], completion: @escaping (NSError?) -> Void) {
        
        Model.coreData.backgroundTask { privateContext in
            
            privateContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
            for item in array {
                
                let cdTool = CDTool(context: privateContext)
                cdTool.fill(item: item)
                
            }
            
            Model.coreData.save(in: privateContext) { status in
                
                Thread.main {
                    completion(status.result(CDVehicle.entityName)?.NSError)
                }
                
            }
            
        }
        
    }
    
    func save(array: [Field], completion: @escaping (NSError?) -> Void) {
        
        Model.coreData.backgroundTask { privateContext in
            
            privateContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
            for item in array {
                
                let cdField = CDField(context: privateContext)
                cdField.fill(item: item)
                
            }
            
            Model.coreData.save(in: privateContext) { status in
                
                Thread.main {
                    completion(status.result(CDVehicle.entityName)?.NSError)
                }
                
            }
            
        }
        
    }
    
    func save(array: [Worker], completion: @escaping (NSError?) -> Void) {
        
        Model.coreData.backgroundTask { privateContext in
            
            privateContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            
            for item in array {
                
                let cdWorker = CDWorker(context: privateContext)
                cdWorker.fill(item: item)
                
            }
            
            Model.coreData.save(in: privateContext) { status in
                
                Thread.main {
                    completion(status.result(CDVehicle.entityName)?.NSError)
                }
                
            }
            
        }
        
    }
    
    //MARK: - Private
    
    private func createField(_ item: Field?, inContext context: NSManagedObjectContext) -> CDField? {
        guard let item = item else { return nil }
        let cdItem = CDField(context: context)
        cdItem.fill(item: item)
        return cdItem
    }
    
    private func createWorker(_ item: Worker?, inContext context: NSManagedObjectContext) -> CDWorker? {
        guard let item = item else { return nil }
        let cdItem = CDWorker(context: context)
        cdItem.fill(item: item)
        return cdItem
    }
    
    private func createOperation(_ item: TaskOperation?, inContext context: NSManagedObjectContext) -> CDTaskOperation? {
        guard let item = item else { return nil }
        let cdItem = CDTaskOperation(context: context)
        cdItem.fill(item: item)
        return cdItem
    }
    
    private func createVehicle(_ item: Vehicle?, inContext context: NSManagedObjectContext) -> CDVehicle? {
        guard let item = item else { return nil }
        let cdItem = CDVehicle(context: context)
        cdItem.fill(item: item)
        return cdItem
    }
    
}
