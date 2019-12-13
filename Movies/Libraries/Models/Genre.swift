//
//  Genre.swift
//  Movies
//
//  Created by Sergey Krasiuk on 11/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import Foundation
import CoreData

@objc(Genre)
class Genre: NSManagedObject {
    
    @NSManaged var name: String?
    
    @nonobjc public class func request() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

}
