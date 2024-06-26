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
    var diffableDataSource: UITableViewDiffableDataSource<FoodRecipeSectionModel, RecipeRowModel>?
    
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
        self.view.backgroundColor = UIColor(named: "Primary Background")
        setupTableView()
        delegate.viewDidLoad()
        self.navigationItem.title = dataSource.foodItem.name
    
    }
    
    func updateView(){
        updateSnapshot()
    }
    
    func setupTableView(){
        tableView.register(RecipeHeaderView.self, forHeaderFooterViewReuseIdentifier: RecipeHeaderView.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.sectionHeaderHeight = 40
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 30.0
        tableView.estimatedSectionFooterHeight = 25
        tableView.isEditing = false
        self.tableView.backgroundColor = UIColor(named: "Primary Grouped Background")
        setupDiffableDataSource()
    }
    
    func setupDiffableDataSource(){
        diffableDataSource = UITableViewDiffableDataSource<FoodRecipeSectionModel, RecipeRowModel>(tableView: self.tableView, cellProvider: {  tableView, indexPath, row in
            return row.getRowCell(tableView: tableView, indexPath: indexPath)
        })

        updateSnapshot()
    }
    
    func updateSnapshot(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<FoodRecipeSectionModel, RecipeRowModel>()
        
        
        //TODO: figure out how to get the right sections
        //TODO: clean up
        
        dataSource.getSections()     // janky
            .forEach { section in
//                if let firstRow = section.rows.first {
//
//                    if firstRow is FoodSummaryRowModel {
//
//                        snapshot.appendItems(section.rows)
//
//                    } else if firstRow is FoodRecipeRowModel {
                        
                        snapshot.appendSections([section])
                        snapshot.appendItems(section.rows)
                        
//                    }
//
//                } else {
//	                    snapshot.appendSections([section])
//                }
//
                
            }

        diffableDataSource?.apply(snapshot, animatingDifferences: animated)
    }
}

extension FoodRecipeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       // Section is just an int, seems like have to do it manually
       // Section 0 is FoodRecipeRowModel
       // Section 1 is FoodSummaryRowModel
        
        guard let diffableDataSource = diffableDataSource else { return 0 }
        
        let sections = diffableDataSource.snapshot().sectionIdentifiers
        let section = sections[section].section
        
        switch section {
        case .recipe:
            return UITableView.automaticDimension
        case .summary:
            return UITableView.automaticDimension
        }
        
//        if (section == 0){
//            return UITableView.automaticDimension
//        }
//        else {
//            return CGFloat.leastNormalMagnitude
//        }
     //  return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        guard let diffableDataSource = diffableDataSource else { return 0 }
        
        let sections = diffableDataSource.snapshot().sectionIdentifiers
        let section = sections[section].section
        
        switch section {
        case .recipe:
            return 30.0
        case .summary:
            return 0.0
        }
        
//        if (section == 0){
//
//            return 50
//        }
//        else {
//            return 0
//        }
        
     //   return UITableView.automaticDimension
        //return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecipeHeaderView.reuseIdentifier) as? RecipeHeaderView,
              let diffableDataSource = diffableDataSource else {
            return nil
        }
        
        let sections = diffableDataSource.snapshot().sectionIdentifiers
        let section = sections[section].section
        
        switch section {
        case .recipe:
            view.title.text = "Ingredients"
        case .summary:
            view.title.text = "Steps"
        }
        
        view.title.textColor = UIColor(named: "Secondary Label")
        view.title.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        return view
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if (section == 0){
//
//            // setting footer with just a background color
//            // kinda ugly color with the rest white, gray is prob best
////
////            let footerView = UIView()
////            let color = UIColor(red: 0.871 ,green: 0.988, blue:  1.0,alpha: 1.0)
////            footerView.backgroundColor = color
////            return footerView
//
//            // setting footer with just "Recipe" string
//            let view = UIView()
//            let footerView = UILabel()
//            footerView.text = "Recipe"
//
//            footerView.translatesAutoresizingMaskIntoConstraints = false
//
//            view.addSubview(footerView)
//
//            NSLayoutConstraint.activate([
//                footerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                footerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//
//            ])
//            return view
//
//        }
//        else {
//            return nil
//        }
//    }
    
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
