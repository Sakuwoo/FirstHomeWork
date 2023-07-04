//
//  File.swift
//  FirstHomeWork
//
//  Created by Sevara on 3/7/23.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    func getRequest(completition: @escaping (Result<ProductsModel,Error>) -> Void) {
        
        guard let url = URL(string: "https://dummyjson.com/products") else { return  }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            
            do {
                let value = try JSONDecoder().decode(ProductsModel.self, from: data)
                completition(.success(value))
            } catch {
                completition(.failure(error))
                
            }
        }
        task.resume()
    }
    
    func postRequest(title: String, id: Int, completition: @escaping (Result<Int, Error>) -> Void
    ) {
        guard let url = URL(string: "https://dummyjson.com/products/add") else { return  }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let model = Product(id: id, title: title)
        request.httpBody = try? JSONEncoder().encode(model)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            do {
                completition(.success(response.statusCode))
            } catch {
                completition(.failure(error))
            }
        }
        task.resume()
    }
}

