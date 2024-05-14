//
//  FoodRecipe.swift
//  LearnSwift
//
//  Created by Zach on 5/12/24.
//

import Foundation

public struct FoodRecipe: Hashable, Decodable{
    let id: String
    let foodItem: FoodItem
    let foodIngredients: [FoodIngredients]
}
