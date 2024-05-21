//
//  DescriptionViewController.swift
//  LearnSwift
//
//  Created by Zach on 4/20/24.
//

import Foundation
import UIKit

protocol FoodRecipeView: AnyObject {
    func setupTableView()
    func updateView()
}

class FoodRecipeViewController: UIViewController, FoodRecipeView{
    
    var delegate: FoodRecipeDelegate!
    var dataSource: FoodRecipeDataSource!
    @IBOutlet weak var tableView: UITableView!
    var diffableDataSource: UITableViewDiffableDataSource<FoodRecipeSectionModel, FoodRecipeRowModel>?
    
    class func instantiateViewController() -> FoodRecipeViewController {
        let bundle = Bundle(for: FoodRecipeViewController.self)
        let storyBoard = UIStoryboard(name: "FoodRecipeViewController", bundle: bundle)
        guard let foodRecipeVC = storyBoard.instantiateInitialViewController() as? FoodRecipeViewController else {
            fatalError("Unable to instantiate FoodRecipeViewController")
        }
        return foodRecipeVC
    }
    
    override func viewDidLoad(){
        super.viewDidLoad();
        self.navigationItem.title = dataSource.foodItem.name
        setupTableView()
        delegate.viewDidLoad()
    
    }
    
    func updateView(){
        //tableView.reloadData()
        updateSnapshot()
    }
    
    func setupTableView(){
        tableView.register(RecipeHeaderView.self, forHeaderFooterViewReuseIdentifier: RecipeHeaderView.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 30.0
        tableView.estimatedSectionFooterHeight = 25
        tableView.isEditing = false
        setupDiffableDataSource()
    }
    
    func setupDiffableDataSource(){
        diffableDataSource = UITableViewDiffableDataSource<FoodRecipeSectionModel, FoodRecipeRowModel>(tableView: self.tableView, cellProvider: {  tableView, indexPath, row in
            return row.getRowCell(tableView: tableView, indexPath: indexPath)
        })

        updateSnapshot()
    }
    
    func updateSnapshot(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<FoodRecipeSectionModel, FoodRecipeRowModel>()

        dataSource.getSections()
            .forEach { section in
                snapshot.appendSections([section])
                snapshot.appendItems(section.rows)
            }

        diffableDataSource?.apply(snapshot, animatingDifferences: animated)
    }
}

extension FoodRecipeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecipeHeaderView.reuseIdentifier) as? RecipeHeaderView else {
            return nil
        }
        view.measurement.text = "Measurement"
        view.ingredients.text = "Ingredients"
        
        return view
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UILabel()
        view.numberOfLines = 0
        view.text = dataSource.foodItem.summary
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
}

//extension FoodRecipeViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // Fetch a cell of the appropriate type.
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.reuseIdentifier, for: indexPath) as? RecipeTableViewCell
//        else {
//            return UITableViewCell()
//        }
//        let ingredientName = dataSource.viewModel.foodRecipe?.foodIngredients[indexPath.row].ingredientName
//        let measurement = dataSource.viewModel.foodRecipe?.foodIngredients[indexPath.row].measurement
//
//        // Configure the cell’s contents.
//        cell.label.text = ingredientName
//        cell.quantity.text = measurement
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataSource.viewModel.foodRecipe?.foodIngredients.count ?? 2
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//}
