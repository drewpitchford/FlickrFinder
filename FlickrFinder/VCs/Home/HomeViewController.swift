//
//  HomeViewController.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/2/18.
//

import UIKit
import DPKitchenSink
import SwifterSwift
import SDWebImage
import SimpleImageViewer
import DataManager
import CoreData

protocol HomeViewControllerDelegate: class {
    
    func fetchPreviousSearchTerms()
}

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var photoFeedCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyViewLabel: UILabel!
    @IBOutlet weak var searchBarContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var previousSearchTermsContainerView: UIView!
    
    // MARK: - Properties
    weak var delegate: HomeViewControllerDelegate?
    private var searchBarDidBeginEditing = false {
        
        didSet {
            
            UIView.animate(withDuration: 0.3) {
                
                self.previousSearchTermsContainerView.alpha = !self.searchBarDidBeginEditing ? 0 : 1
            }
        }
    }
    private var photosProperties: Photos?
    private var photos: [Photo] = [] {
        
        didSet {
            
            emptyViewLabel.isHidden = photos.count != 0
        }
    }
    private var topInset: CGFloat {
        
        return searchBarContainerViewHeightConstraint.constant + view.safeAreaInsets.top
    }
    private var maxCellWidth: CGFloat {
        
        return (UIDevice.current.userInterfaceIdiom == .pad &&
            (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight)) ? 320 : 370
    }
    
    // MARK: - Constants
    private let minimumInterItemSpacing: CGFloat = 12
    private let minimumLineSpacing: CGFloat = 30
    private let contentOffsetPadding: CGFloat = 20
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        setUpUI()
    }
    
    // MARK: - Setup
    func setUpUI() {
        
        // Navigation Bar
        navigationItem.title = "FlickrFinder"
        
        // CollectionView
        photoFeedCollectionView.contentInset = UIEdgeInsets(top: topInset, left: min(contentOffsetPadding, SwifterSwift.screenWidth / 3), bottom: view.safeAreaInsets.bottom, right: min(contentOffsetPadding, SwifterSwift.screenWidth / 3))
        photoFeedCollectionView.scrollIndicatorInsets = photoFeedCollectionView.contentInset
        
        // Container View
        previousSearchTermsContainerView.backgroundColor = .clear
        previousSearchTermsContainerView.blur(using: .prominent)
        previousSearchTermsContainerView.alpha = 0
    }
    
    // MARK: - UI Updates
    func reloadCollectionView() {
        
        photoFeedCollectionView.reloadData()
        if let page = self.photosProperties?.page,
            page == 1 {
            
            self.photoFeedCollectionView.scrollToTop(withPadding: contentOffsetPadding)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? PreviousSearchesViewController {
            
            delegate = destination
            destination.delegate = self
        }
    }
    
    // MARK: - Helpers
    func search(forTerm term: String) {
        
        photos = []
        searchBar.resignFirstResponder()
        searchBarDidBeginEditing = false
        retreivePhotos(withText: term)
    }
}

// MARK: - Networking
extension HomeViewController {
    
    func retreivePhotos(withText text: String, page: Int = 1) {
        
        // Note: AFNetworking probably shouldn't be used with Codable; need to investigate Alamofire
        WebService.shared.retreivePhotos(withText: text, page: page, success: handleSuccess, failure: handleFailure)
    }
    
    // MARK: - Network Handlers
    func handleSuccess(dataTask: URLSessionDataTask, response: Any?) {
        
        guard let json = response as? [String: Any],
            let jsonData = json.jsonData() else {
                
                showAlert(title: "Parsing Error", message: "Failed to get json from AFNetworking")
                return
        }
        
        do {
            
            let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: jsonData)
            self.photosProperties = photosResponse.photos
            self.photos += photosResponse.photos.photo
            self.reloadCollectionView()
        }
        catch {
            
            self.showAlert(for: error)
        }
    }
    
    func handleFailure(dataTask: URLSessionDataTask?, error: Error) {
        
        self.showAlert(for: error)
    }
}

// MARK: - UICollectionViewDelegate methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photo = photos[indexPath.row]
        let photoCell = collectionView.dequeueReusableCell(for: indexPath) as PhotoCollectionViewCell
        photoCell.setUp(with: photo)
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell else {
            
            showAlert(title: "Photo Error", message: "Can not display full photo at this time")
            return
        }
        
        let configuration = ImageViewerConfiguration { (config) in
            
            config.imageView = cell.imageView
        }
        
        let imageViewerController = ImageViewerController(configuration: configuration)
        present(imageViewerController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let photosProperties = photosProperties,
            let searchTerm = searchBar.text,
            indexPath.row == photos.count / 2 {
            
            retreivePhotos(withText: searchTerm, page: photosProperties.page + 1)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = min(photoFeedCollectionView.width / 1.2, maxCellWidth)
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return minimumInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return minimumLineSpacing
    }
}

// MARK: - UISearchBarDelegate methods
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text,
                !searchTerm.isEmpty else {
            
            showAlert(title: "Enter a Search Term", message: "Please enter a word you'd like to search on Flickr")
            return
        }
        
        search(forTerm: searchTerm)
        DataManager.persist(searchTerm: searchTerm)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        if(!searchBarDidBeginEditing) {
            
            delegate?.fetchPreviousSearchTerms()
            searchBarDidBeginEditing = true
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            
            photos = []
            reloadCollectionView()
        }
    }
}

// MARK: - PreviousSearchesVCDelegate Methods
extension HomeViewController: PreviousSearchesViewControllerDelegate {
    
    func previousSearchTermWasSelected(_ term: SearchTerm) {
        
        if let term = term.text {
            
            searchBar.text = term
            search(forTerm: term)
        }
    }
}
