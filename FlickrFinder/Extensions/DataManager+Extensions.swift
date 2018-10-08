//
//  DataManager+Extensions.swift
//  FlickrFinder
//
//  Created by Drew Pitchford on 10/6/18.
//

import Foundation
import DataManager
import CoreData

extension DataManager {
    
    // MARK: - Helpers
    static func persist(searchTerm term: String) {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SearchTerm", in: DataManager.mainContext),
                let newSearchTerm = NSManagedObject(entity: entity, insertInto: DataManager.mainContext) as? SearchTerm else {
            
            print("Could not create entity or object. Will not save this search term")
            return
        }
        
        newSearchTerm.text = term
        DataManager.persist(synchronously: false)
    }
    
    static func fetchPreviousSearchTerms() -> [SearchTerm] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchTerm")
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToFetch = ["text"]
        fetchRequest.returnsDistinctResults = true
        
        do {
            
            guard let fetchedTerms = try DataManager.mainContext.fetch(fetchRequest) as? [[String: Any]] else {
                
                return []
            }
            
            return SearchTerm.parseArray(of: fetchedTerms)
        }
        catch {
            
            return []
        }
    }
}
