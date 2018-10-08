//
//  Photos.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/3/18.
//

import Foundation

class Photos: Decodable {
    
    // MARK: - Properties
    var page: Int
    var pages: Int
    var perPage: Int
    var photo: [Photo] = []
    
    // MARK: - Init
    init(page: Int, pages: Int, perPage: Int, photo: [Photo]) {
        
        self.page = page
        self.pages = pages
        self.perPage = perPage
        self.photo = photo
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        
        case page
        case pages
        case perPage = "perpage"
        case photo
    }
}
