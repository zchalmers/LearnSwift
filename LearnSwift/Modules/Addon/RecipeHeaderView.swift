//
//  RecipeHeaderView.swift
//  LearnSwift
//
//  Created by Zach on 5/15/24.
//

import Foundation
import UIKit

final class RecipeHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: RecipeHeaderView.self)
    
    var ingredients: UILabel = UILabel()
    var measurement: UILabel = UILabel()
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(ingredients)
        contentView.addSubview(measurement)
        
        ingredients.translatesAutoresizingMaskIntoConstraints = false
        measurement.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ingredients.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            ingredients.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            measurement.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            measurement.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])


    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
