//
//  SearchTerm+CoreDataProperties.swift
//  
//
//  Created by Drew Pitchford on 10/6/18.
//
//

import Foundation
import CoreData


extension SearchTerm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchTerm> {
        return NSFetchRequest<SearchTerm>(entityName: "SearchTerm")
    }

    @NSManaged public var text: String?
}
