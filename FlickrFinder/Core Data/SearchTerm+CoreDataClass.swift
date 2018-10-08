//
//  SearchTerm+CoreDataClass.swift
//  
//
//  Created by Drew Pitchford on 10/6/18.
//
//

import Foundation
import CoreData
import DataManager

@objc(SearchTerm)
public class SearchTerm: NSManagedObject {

    // MARK: - Parser
    class func parseArray(of fetchedTerms: [[String: Any]]) -> [SearchTerm] {
        
        var oldTerms: [SearchTerm] = []
        for term in fetchedTerms {
            
            let newSearchTerm = SearchTerm(context: DataManager.mainContext)
            newSearchTerm.text = term["text"] as? String
            oldTerms.append(newSearchTerm)
        }
        
        return oldTerms
    }
}
