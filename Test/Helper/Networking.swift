//
//  Networking.swift
//  Test
//
//  Created by Reyhan on 30/09/22.
//

import Foundation

class NetworkManager{
    static var shared = NetworkManager()
    
    //MARK:
    func fetch<T: Decodable>(queryItem: [URLQueryItem], path: String, page: Int,completion: @escaping(Result<T, Error>) -> Void){
        var component = URLComponents()
        component.queryItems = queryItem
        component.scheme = "https"
        component.path = path
        component.host = "fakestoreapi.com"
        guard let url = component.url else{return}
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data, error == nil else{
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do{
                    let model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
