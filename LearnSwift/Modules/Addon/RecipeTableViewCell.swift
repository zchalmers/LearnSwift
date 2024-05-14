//
//  DescriptionTableViewCell.swift
//  LearnSwift
//
//  Created by Zach on 4/22/24.
//

import Foundation
import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    // Reuse identifier
    public static var reuseIdentifier: String {
        return "\(String(describing: self))"
    }
    
    
}
