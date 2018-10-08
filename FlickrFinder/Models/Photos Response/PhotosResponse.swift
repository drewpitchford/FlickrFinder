//
//  RecentPhotosResponse.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/3/18.
//

import Foundation

class PhotosResponse: Decodable {
    
    // MARK: - Properties
    var photos: Photos
    
    // MARK: - Inits
    init(photos: Photos) {
        
        self.photos = photos
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        
        case photos
    }
}
