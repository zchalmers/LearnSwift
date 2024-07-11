//
//  FoodCategoryPresenter.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import Foundation

protocol FoodCategoryDelegate: AnyObject {
    func viewDidLoad()
    func didTap(row: FoodCategoryRowModel)
}

protocol FoodCategoryDataSource: AnyObject {
    var viewModel: FoodCategoryViewModel { get }
    func getSections() -> [FoodCategorySectionModel]
}

class FoodCategoryPresenter {
    private weak var view: FoodCategoryView?
    var viewModel: FoodCategoryViewModel
    var router: FoodCategoryRouter
    var learnNetworkService: LearnSwiftNetworkService = LearnSwiftNetworkService()
    
    init(view: FoodCategoryView, router: FoodCategoryRouter) {
        self.view = view
        self.router = router
        self.viewModel = FoodCategoryViewModel()
    }
}

extension FoodCategoryPresenter: FoodCategoryDelegate {
    func viewDidLoad() {
        Task{
            await getCategories()
            DispatchQueue.main.async {
                self.view?.updateView()
            }
            
        }
    }
    
    func didTap(row: FoodCategoryRowModel) {
        router.navigateToFoodItems(foodCategory: row.category)
    }
}

extension FoodCategoryPresenter: FoodCategoryDataSource {
    func getCategories() async {
        do {
            let foodCategories = try await learnNetworkService.fetchFoodCategories()
            print("FOOD CATEGROIES")
            print(foodCategories)
            self.viewModel.foodCategories = foodCategories
            
        } catch let error {
            print("FOODCATEGORYPRESENTER ERROR \(error) ")
        }
        
    }
    func getSections() -> [FoodCategorySectionModel] {
        var sectionModels = [FoodCategorySectionModel]()
        
        sectionModels.append(FoodCategorySectionModel(section: .category, rows: viewModel.getRowModels()))
        return sectionModels
    }
    
}
