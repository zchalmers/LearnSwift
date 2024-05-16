//
//  FoodDetail.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import Foundation

// Define a struct to represent food items
public struct FoodItem: Hashable, Decodable {
    let id: String
    let name: String
    let category: FoodCategory
    let description: String
    let summary: String
}
