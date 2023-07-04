//
//  ProductsModel.swift
//  FirstHomeWork
//
//  Created by Sevara on 3/7/23.
//

import Foundation

//MARK: - ProductsModel
struct ProductsModel: Codable {
    let products: [Product]?
    let total, skip, limit: Int?
    
}

//MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, description: String?
    let brand, category: String?
    let thumbnail: String?
    init(id: Int?, title: String?, description: String? = nil, brand: String? = nil, category: String? = nil, thumbnail: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
    }
}
