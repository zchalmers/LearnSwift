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
    var separator: UILabel = UILabel()
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(ingredients)
        contentView.addSubview(measurement)
        contentView.addSubview(separator)
        
        contentView.backgroundColor = .white
        
        ingredients.translatesAutoresizingMaskIntoConstraints = false
        measurement.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        separator.backgroundColor = UIColor.lightGray // Set separator color

        NSLayoutConstraint.activate([
            ingredients.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            ingredients.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            measurement.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            measurement.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 2.0)
        ])


    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
