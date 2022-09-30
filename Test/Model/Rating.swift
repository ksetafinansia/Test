//
//  Rating.swift
//  Test
//
//  Created by Reyhan on 30/09/22.
//

import Foundation


class Rating: Codable{
    var rate: Double!
    var count: Int!
    
    enum CodingKeys: String, CodingKey{
        case rate = "rate"
        case count = "count"
    }
}
