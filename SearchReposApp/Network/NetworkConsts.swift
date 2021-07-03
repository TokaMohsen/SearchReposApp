//
//  NetworkConsts.swift
//  SearchReposApp
//
//  Created by toka mohsen on 03/07/2021.
//

import Foundation
enum Endpoints: String {
    case GitHub = "https://api.github.com/repositories"
    
    
}

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}
