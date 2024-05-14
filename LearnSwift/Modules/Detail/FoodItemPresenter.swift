//
//  FoodItemPresenter.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/11/24.
//

import Foundation

protocol FoodItemDelegate: AnyObject {
    func viewDidLoad()
    func didTap(row: FoodItemRowModel)
}

protocol FoodItemDataSource: AnyObject {
    var viewModel: FoodItemViewModel { get }
    var foodCategory: FoodCategory { get }
    func getSections() -> [FoodItemSectionModel]
}

class FoodItemPresenter {
    private weak var view: FoodItemView?
    var viewModel: FoodItemViewModel
    var foodCategory: FoodCategory
    var foodItems: [FoodItem]?
    var router: FoodItemRouter
    var learnNetworkService: LearnSwiftNetworkService
    
    init(view: FoodItemView, foodCategory: FoodCategory, router: FoodItemRouter) {
        self.view = view
        self.foodCategory = foodCategory
        self.router = router
        self.viewModel = FoodItemViewModel(foodCategory: foodCategory)
        self.learnNetworkService = LearnSwiftNetworkService()
    }
}

extension FoodItemPresenter: FoodItemDelegate {
    func viewDidLoad() {
        Task{
            await getFoodItems()
            DispatchQueue.main.async {
                self.view?.updateView()
            }
        }
    }
    func didTap(row: FoodItemRowModel){
        router.navigateToRecipe(item: row)
    }
}

extension FoodItemPresenter: FoodItemDataSource {
    func getFoodItems() async {
        do {
            let foodItems = try await learnNetworkService.fetchFoodItems(foodCategory: foodCategory)
          
            self.viewModel.foodItems = foodItems
            
        } catch let error {
            print("FOODITEMPRESENTER ERROR \(error) ")
        }
        
    }
    func getSections() -> [FoodItemSectionModel] {
        var sectionModels = [FoodItemSectionModel]()
        
        sectionModels.append(FoodItemSectionModel(section: .item, rows: viewModel.getRowModels()))
        return sectionModels
    }
}
