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
    
    @NSManaged var title: String?
    @NSManaged var image: String?
    @NSManaged var rating: Float
    @NSManaged var releaseYear: Int
    @NSManaged var genres: Set<Genre>?
    
    enum apiKey: String, CodingKey {
        case title
        case image
        case rating
        case releaseYear
        case genres = "genre"
    }
    
    @nonobjc public class func request() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
    
    // MARK: - Decodable
        
    public required convenience init(from decoder: Decoder) throws {
            
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let manageObjContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let manageObjMovie = NSEntityDescription.entity(forEntityName: "Movie", in: manageObjContext) else {
            fatalError("Error to getting context")
        }
        
        self.init(entity: manageObjMovie, insertInto: manageObjContext)
        
        let container = try decoder.container(keyedBy: apiKey.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.rating = try container.decodeIfPresent(Float.self, forKey: .rating) ?? 0
        self.releaseYear = try container.decodeIfPresent(Int.self, forKey: .releaseYear) ?? 0
        
        let genreData = try container.decodeIfPresent([String].self, forKey: .genres) ?? []
        let genreArray = genreData.map { name -> Genre in
            let genre = Genre(context: manageObjContext)
            genre.name = name
            return genre
        }
        
        self.genres = Set(genreArray)
    }
}

// MARK: Generated accessors for geonames
extension Movie {

    @objc(addGenresObject:)
    @NSManaged func addToGenres(_ value: Genre)
    
    @objc(setKeyObject:)
    @NSManaged func setKeyObject(_ value: String)
}
