//
//  Movie.swift
//  Movies
//
//  Created by Sergey Krasiuk on 11/12/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import Foundation
import CoreData

@objc(Movie)
class Movie: NSManagedObject, Decodable {
    
    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var rating: Float
    @NSManaged public var releaseYear: Int
    @NSManaged public var genre: Set<String>
    
    enum apiKey: String, CodingKey {
        case title
        case image
        case rating
        case releaseYear
        case genre
    }
    
    @nonobjc public class func request() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
    
    // MARK: - Decodable
        
    public required convenience init(from decoder: Decoder) throws {
            
        guard let contextUserInfoKey = CodingUserInfoKey.context else {
            fatalError("cannot find context key")
        }
         
        guard let manageObjContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else {
            fatalError("Cannot Retrieve NSManagedObjectContext context")
        }
        
        guard let manageObjGeoname = NSEntityDescription.entity(forEntityName: "Movie", in: manageObjContext) else {
            fatalError("Cannot Retrieve Entity")
        }
        
        self.init(entity: manageObjGeoname, insertInto: manageObjContext)
        
        let container = try decoder.container(keyedBy: apiKey.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.rating = try container.decodeIfPresent(Float.self, forKey: .rating) ?? 0
        self.releaseYear = try container.decodeIfPresent(Int.self, forKey: .releaseYear) ?? 0
        self.genre = try container.decode(Set<String>.self, forKey: .genre)
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
