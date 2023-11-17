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
    
    
}
