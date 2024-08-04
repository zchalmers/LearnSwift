//
//  RecipePresenter.swift
//  LearnSwift
//
//  Created by Chalmers on 7/31/24.
//

import Foundation


protocol RecipeViewDelegate: AnyObject {
    func viewDidLoad()
}

protocol RecipeViewDataSource: AnyObject {
    var viewModel: FoodRecipeViewModel { get }
    var foodItem: FoodItem { get }
}

class RecipeViewPresenter {
    private weak var view: FoodItemRecipeView?
    var viewModel: FoodRecipeViewModel
    var foodItem: FoodItem
    var learnNetworkService: LearnSwiftNetworkService
    
    init(view: FoodItemRecipeView, foodItem: FoodItem){
        self.view = view
        self.foodItem = foodItem
        self.viewModel = FoodRecipeViewModel()
        self.learnNetworkService = LearnSwiftNetworkService()
    }
}

extension RecipeViewPresenter: RecipeViewDelegate {
    func viewDidLoad(){
        Task {
            await getRecipe()
            DispatchQueue.main.async {
                self.view?.updateView()
            }
        }
    }
}

extension RecipeViewPresenter: RecipeViewDataSource {
    func getRecipe() async {
        do {
            let foodRecipe = try await learnNetworkService.fetchFoodRecipe(foodItem: self.foodItem)
            
            self.viewModel.foodRecipe = foodRecipe
            
        } catch let error {
            print("FOODRECIPEPRESENTER ERROR \(error) ")
            
        }
    }
}



