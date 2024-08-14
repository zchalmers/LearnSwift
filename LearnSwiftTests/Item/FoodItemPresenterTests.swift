//
//  FoodItemPresenterTests.swift
//  LearnSwiftTests
//
//  Created by Chalmers on 8/12/24.
//

@testable import LearnSwift
import XCTest

final class FoodItemPresenterTests: XCTestCase {
    
    private var mockViewController: FoodItemViewMock!
    private var mockRouter: FoodItemRouterMock!
    private var mockNetworkService: LearnSwiftNetworkServiceMock!
    
//    private var networkService = LearnSwiftNetworkService()
    private var presenter: FoodItemPresenter!
    
    override func setUp() async throws {
        mockViewController = FoodItemViewMock()
        mockRouter = FoodItemRouterMock()
        mockNetworkService = LearnSwiftNetworkServiceMock()
        mockNetworkService.createData()
        
        do {
            if let category = try await mockNetworkService.fetchFoodCategories().first(where: {$0.name == "Appetizers"}) {
                presenter = FoodItemPresenter(view: mockViewController, foodCategory: category, router: mockRouter, networkService: mockNetworkService)
            } else {
                throw RequestError.error("Invalid Category")
            }
        } catch {
            print(error)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewDidLoad() {
        
        let viewDidLoadExp = expectation(description: "Need to wait for update View")
        
        mockViewController.updateViewCallback = {
            viewDidLoadExp.fulfill()
        }
        
        presenter.viewDidLoad()
        
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(mockViewController.didCallUpdateView)
        XCTAssertEqual(presenter.viewModel.foodItems.count, 3)
        XCTAssertEqual(presenter.viewModel.foodItems.first?.name, "Bruschetta")
        
//        XCTAssertFalse(presenter.getSections().isEmpty)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


fileprivate class FoodItemViewMock: FoodItemView {

    var isSearching: Bool = false
    var searchController: UISearchController?
    
    /** Update View */
    var updateViewCallback: (() -> Void)?
    var didCallUpdateView = false

    func updateView() {
        didCallUpdateView = true
        updateViewCallback?()
    }
    
    /** Setup TableView */
    var setupTableViewCallback: (() -> Void)?
    var didCallSetupTableView = false
    
    func setupTableView() {
        didCallSetupTableView = true
        setupTableViewCallback?()
    }
}

fileprivate class FoodItemRouterMock: FoodItemRouter {
    
    var navigateToRecipeCallBack: (() -> Void)?
    func navigateToRecipe(item: FoodItemRowModel) {
        navigateToRecipeCallBack?()
    }
    
    var navigateToRecipeViewCallBack: (() -> Void)?
    func navigateToRecipeView(item: FoodItemRowModel) {
        navigateToRecipeViewCallBack?()
    }
}
