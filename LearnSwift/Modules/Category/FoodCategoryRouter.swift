//
//  FoodCategoryRouter.swift
//  LearnSwift
//
//  Created by Zach on 4/8/24.
//

import Foundation

protocol FoodCategoryRouter: ErrorScreenRouter {
    func navigateToFoodItems(foodCategory: FoodCategory)
}
