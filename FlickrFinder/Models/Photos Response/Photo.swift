//
//  Photo.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/3/18.
//

import Foundation

class Photo: Decodable {
    
    // MARK: - Properties
    var isFamily: Int
    var isFriend: Int
    var isPublic: Int
    var farm: Int
    var id: String
    var owner: String
    var secret: String
    var server: String
    var title: String
    var imageURL: URL? {
        
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg")
    }
    
    // MARK: - Inits
    init(isFamily: Int, isFriend: Int, isPublic: Int, farm: Int, id: String, owner: String, secret: String, server: String, title: String) {
        
        self.isFamily = isFamily
        self.isFriend = isFriend
        self.isPublic = isPublic
        self.farm = farm
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.title = title
    }
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        
        case isFamily = "isfamily"
        case isFriend = "isfriend"
        case isPublic = "ispublic"
        case farm
        case id
        case owner
        case secret
        case server
        case title
    }
}
