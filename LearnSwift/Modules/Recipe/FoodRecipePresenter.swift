//
//  FoodDescriptionPresenter.swift
//  LearnSwift
//
//  Created by Zach on 4/20/24.
//

import Foundation


protocol FoodRecipeDelegate: AnyObject {
    func viewDidLoad()
}

protocol FoodRecipeDataSource: AnyObject {
    var viewModel: FoodRecipeViewModel { get }
    var foodItem: FoodItem { get }
    func getSections() -> [FoodRecipeSectionModel]
    
}
class FoodRecipePresenter {
    private weak var view: FoodRecipeView?
    var viewModel: FoodRecipeViewModel
    var foodItem: FoodItem
    var learnNetworkService: LearnSwiftNetworkService
    
    init(view: FoodRecipeView, foodItem: FoodItem){
        self.view = view
        self.foodItem = foodItem
        self.viewModel = FoodRecipeViewModel()
        self.learnNetworkService = LearnSwiftNetworkService()
    }
}

extension FoodRecipePresenter: FoodRecipeDelegate {
    func viewDidLoad(){
        Task {
            await getRecipe()
            DispatchQueue.main.async {
                self.view?.updateView()
            }
        }
    }
}

extension FoodRecipePresenter: FoodRecipeDataSource {
    func getRecipe() async {
        do {
            let foodRecipe = try await learnNetworkService.fetchFoodRecipe(foodItem: self.foodItem)
            
            self.viewModel.foodRecipe = foodRecipe
            
        } catch let error {
            print("FOODRECIPEPRESENTER ERROR \(error) ")
            
        }
    }
    
    func getSections() -> [FoodRecipeSectionModel] {
        var sectionModels = [FoodRecipeSectionModel]()
        
        sectionModels.append(FoodRecipeSectionModel(section: .recipe, rows: viewModel.getRowModels()))
        
        sectionModels.append(FoodRecipeSectionModel(section: .summary, rows: [FoodSummaryRowModel(foodItem: foodItem)]))
        return sectionModels
    }
}


