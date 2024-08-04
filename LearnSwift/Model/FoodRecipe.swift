//
//  FoodRecipe.swift
//  LearnSwift
//
//  Created by Zach on 5/12/24.
//

import Foundation

public struct FoodRecipe: Hashable, Decodable, Identifiable {
    public let id: String
    public let foodItem: FoodItem
    public let foodIngredients: [FoodIngredients]
}
