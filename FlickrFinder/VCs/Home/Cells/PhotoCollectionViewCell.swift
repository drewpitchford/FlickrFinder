//
//  PhotoCollectionViewCell.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/5/18.
//

import UIKit
import Reusable
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - ReuseID
    static let photoCollectionViewCell = "PhotoCollectionViewCell"
    
    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Setup
    func setUp(with photo: Photo) {
        
        setUpUI()
        titleLabel.text = photo.title
        imageView.sd_setImage(with: photo.imageURL, completed: nil)
    }
    
    func setUpUI() {
        
        backgroundColor = .white
        borderColor = .white
        borderWidth = 0.1
        
        layer.cornerRadius = UIConstants.Radii.standard
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
    }
}
