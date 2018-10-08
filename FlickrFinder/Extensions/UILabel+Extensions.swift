//
//  UILabel+Extensions.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/6/18.
//

import Foundation
import UIKit

extension UILabel {
    
    // MARK: - Lifecycle
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        font = UIFont.systemFont(ofSize: FontConstants.Size.standard, weight: FontConstants.Weight.standard)
    }
}
