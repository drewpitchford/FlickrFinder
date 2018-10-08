//
//  Constants+UI.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/6/18.
//

import Foundation
import UIKit

// MARK: - UIConstants
typealias UIConstants = Constants.UI
extension Constants.UI {
    
    struct Radii {
        
        static let standard: CGFloat = 7
        static let rounder: CGFloat = 10
    }
    
    struct Font {}
}

// MARK: - UIFont Constants
typealias FontConstants = UIConstants.Font
extension UIConstants.Font {
    
    struct Weight {
        
        static let standard: UIFont.Weight = .medium
    }
    
    struct Size {
        
        static let standard: CGFloat = 17
    }
}
