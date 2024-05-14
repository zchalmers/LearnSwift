//
//  Foodingredients.swift
//  LearnSwift
//
//  Created by Zach on 5/12/24.
//

import Foundation

public struct FoodIngredients: Hashable, Decodable {
    let id: String
    let ingredientName: String
    let measurement: String
}
