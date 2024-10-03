//
//  MenuItem.swift
//  Restaurant
//
//  Created by MainUser on 2/10/2024.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    
    // Additional Properties
    let dishDescription: String
    let category: String
    let id: Int
    
    // This is because description is already used
    enum CodingKeys: String, CodingKey {
        case title, image, price
        case category, id
        case dishDescription = "description"
    }
}
