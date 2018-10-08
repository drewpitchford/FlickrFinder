//
//  WebService.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/2/18.
//

import Foundation
import AFNetworking

typealias SuccessClosure = ((URLSessionDataTask, Any?) -> Void)?
typealias FailureClosure = ((URLSessionDataTask?, Error) -> Void)?

class WebService: AFHTTPSessionManager {
    
    // MARK: - Singleton
    static var shared: WebService {
        
        let webService = WebService(baseURL: URL(string: WebURLs.base))
        webService.requestSerializer = AFJSONRequestSerializer()
        webService.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        webService.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        webService.requestSerializer.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        webService.responseSerializer = AFJSONResponseSerializer()
        return webService
    }
    
    // MARK: - Photo Retreival
    func retreivePhotos(withText text: String, page: Int = 1, success: SuccessClosure, failure: FailureClosure) {
        
        let params: [String: Any] = [JSONKeys.method: WebMethods.Photos.search, JSONKeys.text: text, JSONKeys.apiKey: WebConstants.apiKey, JSONKeys.format: WebFormats.json, JSONKeys.noJsonCallback: "?", JSONKeys.perPage: WebConstants.perPageLimit, JSONKeys.page: page]
        get("", parameters: params, progress: nil, success: success, failure: failure)
    }
}
