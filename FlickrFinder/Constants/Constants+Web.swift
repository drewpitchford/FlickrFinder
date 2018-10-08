//
//  Constants+Web.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/6/18.
//

import Foundation

// MARK: - Web Constants
typealias WebConstants = Constants.Web
extension Constants.Web {
    
    static let apiKey = "1508443e49213ff84d566777dc211f2a"
    static let perPageLimit = 25
    struct URLs {}
    struct Methods {}
    struct Formats {}
}

// MARK: - Web URLs
typealias WebURLs = WebConstants.URLs
extension WebConstants.URLs {
    
    static let base = "https://api.flickr.com/services/rest/"
}

// MARK: - Web Methods
typealias WebMethods = WebConstants.Methods
extension WebConstants.Methods {
    
    struct Photos {
        
        static let recent = "flickr.photos.getRecent"
        static let search = "flickr.photos.search"
    }
}

// MARK: - Web Response Formats
typealias WebFormats = WebConstants.Formats
extension WebConstants.Formats {
    
    static let json = "json"
}

// MARK: - Json Keys
typealias JSONKeys = Constants.JSONKeys
extension Constants.JSONKeys {
    
    static let method = "method"
    static let apiKey = "api_key"
    static let format = "format"
    static let text = "text"
    static let noJsonCallback = "nojsoncallback"
    static let perPage = "per_page"
    static let page = "page"
}
