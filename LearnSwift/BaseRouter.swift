//
//  BaseRouter.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import Foundation
import UIKit

public class BaseRouter: FoodCategoryRouter, FoodItemRouter {
    
    var viewStackManager: ViewControllerStackManaging
    
    init(viewStackManager: ViewControllerStackManaging = UINavigationController()) {
        self.viewStackManager = viewStackManager
    }
    
    func navigateToFoodItems(foodCategory: FoodCategory) {
        let tableViewController = FoodItemViewController.instantiateViewController()
        let presenter = FoodItemPresenter(view: tableViewController, foodCategory: foodCategory, router: self)
        tableViewController.delegate = presenter
        tableViewController.dataSource = presenter
        
        // This is to get the SceneDelegate object
        // then call the change root view controller function to change to main app view to a new Navigation Controller
        viewStackManager.push(tableViewController, animated: true)
    }
    
    func navigateToRecipe(item: FoodItemRowModel) {
        let recipeViewController = FoodRecipeViewController.instantiateViewController()
        let presenter = FoodRecipePresenter(view: recipeViewController, foodItem: item.item)
        
        recipeViewController.delegate = presenter
        recipeViewController.dataSource = presenter
        
        viewStackManager.push(recipeViewController, animated: true)
    }
}

extension BaseRouter: ErrorScreenRouter {
    func navigateToErrorScreen() {
    }
    
    func dismissErrorScreen() {
        viewStackManager.dismissModal()
    }
}
