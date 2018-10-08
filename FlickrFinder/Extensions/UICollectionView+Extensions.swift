//
//  UICollectionView+Extensions.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/6/18.
//

import Foundation
import UIKit

extension UICollectionView {
    
    // MARK: - Scrolling
    func scrollToTop(withPadding padding: CGFloat = 0.0) {
        
        contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top - padding)
    }
}
