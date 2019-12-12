//
//  WebServiceManager.swift
//  Movies
//
//  Created by Sergey Krasiuk on 04/11/2019.
//  Copyright © 2019 Sergey Krasiuk. All rights reserved.
//

import Foundation

class WebServiceManager {
    
    enum WebServiceAPI: String {
        case movies = "http://api.androidhive.info/json/movies.json"
    }
    
    static let shared = WebServiceManager()
    private init() {}
    
    func fetch(fromWebService service: WebServiceAPI, withParameters parameters: [String: String], completion: @escaping ((Error?) -> Void)) {
        
        guard var components = URLComponents(string: service.rawValue) else {
            return
        }
        
        components.queryItems = parameters.map({ URLQueryItem(name: $0.key, value: $0.value) })
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: " ", with: "%20")
        
        let request = URLRequest(url: components.url!)
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let responseData = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil else {
                    
                completion(error)
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = CoreDataManager.shared.context
                _ = try decoder.decode([Movie].self, from: responseData)
                CoreDataManager.shared.saveContext()
                completion(nil)
                
            } catch let error {
                print(error.localizedDescription)
                completion(error)
            }
        }
        
        session.resume()
    }
}

extension JSONDecoder {
    
    func decode<T: Decodable>(_ type: T.Type, withJSONObject object: Any, options opt: JSONSerialization.WritingOptions = []) throws -> T {
        
        let data = try JSONSerialization.data(withJSONObject: object, options: opt)
        return try decode(T.self, from: data)
    }
}
