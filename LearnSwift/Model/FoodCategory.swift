//
//  FoodCategory.swift
//  LearnSwift
//
//  Created by Zach on 4/8/24.
//

import Foundation

// Define a struct to represent a food category
public struct FoodCategory: Hashable, Decodable, Identifiable {
    public let id: String
    public let name: String

}
