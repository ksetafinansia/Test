//
//  Networking.swift
//  Test
//
//  Created by Reyhan on 30/09/22.
//

import Foundation

class NetworkManager{
    static var shared = NetworkManager()
    
    func getProducts<T: Decodable>(completion: @escaping(Result<T, Error>) -> Void){
        var component = URLComponents()
        component.queryItems = []
        component.scheme = "https"
        component.path = "/products"
        component.host = "fakestoreapi.com"
        print(component.url?.absoluteString)
        guard let url = component.url else{return}
        var session = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data, error == nil else{
                return
            }
            if let data = data {
                var decoder = JSONDecoder()
                do{
                    var model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
}
