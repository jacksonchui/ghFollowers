//
//  Follower.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/18/21.
//
/*
 Has to match with json from the internet (unless you want to wrap it)
 Decodable can convert from snake_case to CamelCase
 */

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    /* custom hash function
     func hash(into hasher: inout Hasher) {
        hasher.combine(login)
     }
     */
}
