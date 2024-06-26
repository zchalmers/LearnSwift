//
//  FoodCategoryRouter.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import Foundation

protocol FoodCategoryRouter: ErrorScreenRouter {
    func navigateToFoodItems(foodCategory: FoodCategory)
}
