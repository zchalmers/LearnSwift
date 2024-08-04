//
//  FoodDetail.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import Foundation

// Define a struct to represent food items
public struct FoodItem: Hashable, Decodable, Identifiable {
    public let id: String
    public let name: String
    public let category: FoodCategory
    public let description: String
    public let summary: String
}
