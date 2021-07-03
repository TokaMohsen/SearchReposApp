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
    let createdAt : Date
  

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


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
