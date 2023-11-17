//
//  Api.swift
//  AgroFarm
//
//  Created by Grigory Sapogov on 15.11.2023.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidData
}

final class Api {
    
    private let server: String = "http://45.12.74.18:8000/api"
    
    func fetchJson(request: String, completion: @escaping (Result<[String: Any], NSError>) -> Void) {
        
        self.fetchData(request: request) { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                
                Thread.run {
                    guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        Thread.main {
                            completion(.failure(ApiError.invalidData.NSError))
                        }
                        return
                    }
                    
                    Thread.main {
                        completion(.success(json))
                    }
                }
                
            }
            
            
            
        }
        
    }
    
    func fetchArray(request: String, completion: @escaping (Result<[[String: Any]], NSError>) -> Void) {
        
        self.fetchData(request: request) { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                
                Thread.run {
                    guard let array = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
                        Thread.main {
                            completion(.failure(ApiError.invalidData.NSError))
                        }
                        return
                    }
                    
                    Thread.main {
                        completion(.success(array))
                    }
                }
                
            }
            
        }
        
    }
    
    private func fetchData(request: String, completion: @escaping (Result<Data, NSError>) -> Void) {
        
        Thread.run {
            
            let url = "\(self.server)/\(request)"
            
            guard let request = URL(string: url) else {
                Thread.main {
                    completion(.failure(ApiError.invalidUrl.NSError))
                }
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                
                guard let data = data else {
                    Thread.main {
                        completion(.failure(ApiError.invalidData.NSError))
                    }
                    return
                    
                }
                
                Thread.main {
                    completion(.success(data))
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
}
