//
//  Product.swift
//  Test
//
//  Created by Reyhan on 30/09/22.
//

import Foundation

class Product: Codable{
    var id: Int!
    var title: String!
    var price: Double!
    var description: String!
    var category: String!
    var image: String!
    var rating: Rating!
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case title = "title"
        case price = "price"
        case description = "description"
        case category = "category"
        case image = "image"
        case rating = "rating"
    }
}
