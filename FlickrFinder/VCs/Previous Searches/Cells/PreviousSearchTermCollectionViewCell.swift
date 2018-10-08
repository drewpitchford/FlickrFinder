//
//  PreviousSearchTermCollectionViewCell.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/6/18.
//

import UIKit
import Reusable

class PreviousSearchTermCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchTermLabel: UILabel!
    
    // MARK: - Constants
    static let height: CGFloat = 50 // From Storyboard (default value)
    static let width: CGFloat = 120 // From Storyboard (default value)
    
    // MARK: - Setup
    func setUp(withTerm term: SearchTerm) {
        
        setUpUI()
        searchTermLabel.text = term.text
    }
    
    private func setUpUI() {
        
        searchTermLabel.clipsToBounds = true
        searchTermLabel.layer.cornerRadius = UIConstants.Radii.rounder
        searchTermLabel.backgroundColor = .white
        searchTermLabel.textColor = .blue
    }
}
