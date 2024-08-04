//
//  Foodingredients.swift
//  LearnSwift
//
//  Created by Zach on 5/12/24.
//

import Foundation

public struct FoodIngredients: Hashable, Decodable, Identifiable {
    public let id: String
    public let ingredientName: String
    public let measurement: String
}
