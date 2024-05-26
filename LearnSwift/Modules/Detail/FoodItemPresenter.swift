//
//  FoodItemPresenter.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/11/24.
//

import Foundation
import UIKit
import Combine

protocol FoodItemDelegate: AnyObject {
    func viewDidLoad()
    func didTap(row: FoodItemRowModel)
}

protocol FoodItemDataSource: AnyObject {
    var viewModel: FoodItemViewModel { get }
    var foodCategory: FoodCategory { get }
    func getSections() -> [FoodItemSectionModel]
}

class FoodItemPresenter: NSObject {
    private weak var view: FoodItemView?
    var viewModel: FoodItemViewModel
    var foodCategory: FoodCategory
    var foodItems: [FoodItem]?
    var router: FoodItemRouter
    var learnNetworkService: LearnSwiftNetworkService
    
    @Published var searchKey: String = ""
    var searchResult: AnyCancellable?
    
    init(view: FoodItemView, foodCategory: FoodCategory, router: FoodItemRouter) {
        self.view = view
        self.foodCategory = foodCategory
        self.router = router
        self.viewModel = FoodItemViewModel(foodCategory: foodCategory)
        self.learnNetworkService = LearnSwiftNetworkService()
    }
}

extension FoodItemPresenter: FoodItemDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
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
    
    // MARK: UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            view?.isSearching = true
            // Handle search results when cancelling an empty search
            if searchString.isEmpty && searchKey == searchString {
                handleSearchResults(for: "")
            } else {
                self.searchKey = searchString
            }
        }
    }

    // MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view?.isSearching = false
        searchKey = ""
    }
    
    
    func handleSearchResults(for query: String) {
        
        guard let view = view else { return }
        
        if !query.isEmpty {
            //            view.showLoadingIndicator()
            
            viewModel.searchFoodItems = foodItems?.filter { $0.name.contains(query) } ?? [FoodItem]()
            view.updateView()
            
        } else {
            if view.isSearching {
                view.isSearching = false
                viewModel.searchFoodItems.removeAll()
                view.updateView()
            }
        }
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
        
        if view?.isSearching ?? false {
            sectionModels.append(FoodItemSectionModel(section: .item, rows: viewModel.getSearchRowModels()))
        } else {
            sectionModels.append(FoodItemSectionModel(section: .item, rows: viewModel.getRowModels()))
        }
        
        return sectionModels
    }
    
    // MARK: Search Subscriber
    func searchSubscriber() {
        searchResult = $searchKey
            .debounce(for: 1.0, scheduler: RunLoop.main)
            .compactMap { $0 }
            .removeDuplicates()
            .sink(receiveValue: { [weak self] query in
                self?.handleSearchResults(for: query.lowercased())
            })
    }
}
