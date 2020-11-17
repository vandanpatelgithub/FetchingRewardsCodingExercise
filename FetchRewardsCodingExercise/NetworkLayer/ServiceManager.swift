//
//  ServiceManager.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/17/20.
//

import Foundation

protocol ServiceManagale {
    func fetchItems(completion: @escaping (Result<[Item], Error>) -> ())
}

struct ServiceManager: ServiceManagale {
    func fetchItems(completion: @escaping (Result<[Item], Error>) -> ()) {
        let endpoint = ItemsListAPI.fetchItems
        guard let request = endpoint.buildRequest else { return }
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let items = try JSONDecoder().decode([Item].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
