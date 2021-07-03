//
//  GitRepoInformationResponse.swift
//  SearchReposApp
//
//  Created by toka mohsen on 01/07/2021.
//

import Foundation

// MARK: - Config
struct RepoInfo: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let configPrivate: Bool
    let owner: Owner
    let htmlURL: String
    let configDescription: String
    let fork: Bool
    let url: String
    let createdAt : String
  

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case configPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case configDescription = "description"
        case fork, url
        case createdAt = "created_at"
       
    }
}
