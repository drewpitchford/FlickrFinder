//
//  PreviousSearchesViewController.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/6/18.
//

import UIKit
import DataManager

protocol PreviousSearchesViewControllerDelegate: class {
    
    func previousSearchTermWasSelected(_ term: SearchTerm)
}

class PreviousSearchesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emptyViewLabel: UILabel!
    @IBOutlet weak var previousSearchTermsCollectionView: UICollectionView!
    
    // MARK: - Properties
    weak var delegate: PreviousSearchesViewControllerDelegate?
    private var previousSearchTerms: [SearchTerm] = [] {
        
        didSet {
            
            emptyViewLabel.isHidden = previousSearchTerms.count != 0
        }
    }
    
    // MARK: - Constants
    private let horizontalInsetPadding: CGFloat = 20.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        previousSearchTermsCollectionView.contentInset = UIEdgeInsets(horizontal: view.safeAreaInsets.left + horizontalInsetPadding, vertical: 0)
    }
}

// MARK: - UICollectionViewDelegate Methods
extension PreviousSearchesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return previousSearchTerms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath) as PreviousSearchTermCollectionViewCell
        let term = previousSearchTerms[indexPath.row]
        cell.setUp(withTerm: term)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let searchTerm = previousSearchTerms[indexPath.row]
        delegate?.previousSearchTermWasSelected(searchTerm)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout methods
extension PreviousSearchesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let term = previousSearchTerms[indexPath.row]
        guard let text = term.text else {
            
            // Return a default size if text cannot be unwrapped
            return CGSize(width: PreviousSearchTermCollectionViewCell.width, height: PreviousSearchTermCollectionViewCell.height)
        }
        
        let font = UIFont.systemFont(ofSize: FontConstants.Size.standard)
        let size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
        let widthPadding: CGFloat = 50
        
        return CGSize(width: size.width + widthPadding, height: PreviousSearchTermCollectionViewCell.height)
    }
}

// MARK: - HomeViewControllerDelegate Methods
extension PreviousSearchesViewController: HomeViewControllerDelegate {
    
    func fetchPreviousSearchTerms() {
        
        previousSearchTerms = DataManager.fetchPreviousSearchTerms()
        previousSearchTermsCollectionView.reloadData()
    }
}
