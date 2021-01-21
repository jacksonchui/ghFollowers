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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                // completed(nil, error.localizedDescription) // This is a no no no.
                completed(.failure(.invalidData))
            }
        }
        
        task.resume() // starts network call
    }
    
    func getImage(from urlString: String, completed: @escaping(Result<UIImage, GFError>) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = self.cache.object(forKey: cacheKey ) {
            completed(.success(image))
            return
        }
        guard let url = URL(string: urlString) else {
            completed(.failure(.unableToComplete))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            let image = UIImage(data: data)!
            completed(.success(image))
        }
        
        task.resume()
    }
}
