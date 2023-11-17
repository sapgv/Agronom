//
//  WorkerListViewModel.swift
//  Agronom
//
//  Created by Grigory Sapogov on 18.11.2023.
//

import Foundation

final class WorkerListViewModel {

    private let service: Service
    
    private let storage: Storage
    
    var updateCompletion: ((NSError?) -> Void)?
    
    init(storage: Storage = Storage(),
         service: Service = Service()) {
        self.storage = storage
        self.service = service
    }
    
    func updateData() {
        
        self.service.fetchWorkers { [weak self] result in
            
            switch result {
            case let .failure(error):
                self?.updateCompletion?(error)
            case let .success(array):
                self?.storage.save(array: array) { error in
                    self?.updateCompletion?(error)
                }
            }
            
        }
    }
    
}
