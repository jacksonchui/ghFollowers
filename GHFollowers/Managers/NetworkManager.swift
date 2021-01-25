//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/18/21.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/"
    let cache            = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], GFError>) -> Void) {
        let followersPerPage = 100
        let endpoint = baseURL + "users/\(username)/followers?per_page=\(followersPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // check for an error
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            // check for a completed response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            // check for valid data
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // after handling everything we try catch when decoding the data
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                // completed(nil, error.localizedDescription) // This is a no no no.
                completed(.failure(.invalidData))
            }
        }
        
        task.resume() // starts network call
    }
    
    func getUserInfo(for username: String, completed: @escaping(Result<User, GFError>) -> Void) {
        let endpoint = baseURL + "users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // check for an error
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            // check for a completed response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            // check for valid data
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // after handling everything we try catch when decoding the data
            do {
                let decoder                      = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                // completed(nil, error.localizedDescription) // This is a no no no.
                completed(.failure(.invalidData))
            }
        }
        
        task.resume() // starts network call
    }
    
    func getImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey ) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
