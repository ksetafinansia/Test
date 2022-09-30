//
//  Networking.swift
//  Test
//
//  Created by Reyhan on 30/09/22.
//

import Foundation

class NetworkManager{
    //MARK: Variable
    static var shared = NetworkManager()
    
    //MARK: Fetch
    func fetch<T: Decodable>(queryItem: [URLQueryItem], path: String, completion: @escaping(Result<T, Error>) -> Void){
        //TODO: Create enum or class for URL
        var component = URLComponents()
        component.queryItems = queryItem
        component.scheme = "https"
        component.path = path
        component.host = APIEndpoint.baseURL
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
