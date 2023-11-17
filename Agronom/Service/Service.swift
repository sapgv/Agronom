//
//  Service.swift
//  AgroFarm
//
//  Created by Grigory Sapogov on 15.11.2023.
//

import Foundation

final class Service {
    
    private let api: Api
    
    init(api: Api = Api()) {
        self.api = api
    }
    
    func fetchTasks(completion: @escaping (Result<[TaskManager], NSError>) -> Void) {
        
        self.api.fetchArray(request: "todos") { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(value):
                
                Thread.run {
                    
                    let array = value.map {
                        TaskManager($0)
                    }

                    Thread.main {
                        completion(.success(array))
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func fetchVehicles(completion: @escaping (Result<[Vehicle], NSError>) -> Void) {
        
        self.api.fetchArray(request: "vehicles") { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(value):
                
                Thread.run {
                    
                    let array = value.map {
                        Vehicle($0)
                    }
                    
                    Thread.main {
                        completion(.success(array))
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func fetchOperations(completion: @escaping (Result<[TaskOperation], NSError>) -> Void) {
        
        self.api.fetchArray(request: "operations") { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(value):

                Thread.run {

                    let array = value.map {
                        TaskOperation($0)
                    }

                    Thread.main {
                        completion(.success(array))
                    }

                }
                
            }
            
        }
        
    }
    
    func fetchTools(completion: @escaping (Result<[VehicleTool], NSError>) -> Void) {
        
        self.api.fetchArray(request: "equipment") { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(value):

                Thread.run {

                    let array = value.map {
                        VehicleTool($0)
                    }

                    Thread.main {
                        completion(.success(array))
                    }

                }
                
            }
            
        }
        
    }
    
    func fetchFields(completion: @escaping (Result<[Field], NSError>) -> Void) {
        
        self.api.fetchArray(request: "fields") { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(value):

                Thread.run {

                    let array = value.map {
                        Field($0)
                    }

                    Thread.main {
                        completion(.success(array))
                    }

                }
                
            }
            
        }
        
    }
    
    func fetchWorkers(completion: @escaping (Result<[Worker], NSError>) -> Void) {
        
        self.api.fetchArray(request: "workers") { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(value):

                Thread.run {

                    let array = value.map {
                        Worker($0)
                    }

                    Thread.main {
                        completion(.success(array))
                    }

                }
                
            }
            
        }
        
    }
    
    
}
