//
//  GetOwnerInfoService.swift
//  SearchReposApp
//
//  Created by toka mohsen on 03/07/2021.
//

import Foundation
class GetOwnerInfoService{
    
    func getRepoCreationDate(from detailsURL: String, completion: @escaping (Result<String, APIServiceError>) -> Void) {
        if let url = URL(string: detailsURL) {
            APIClient<RepoInfo>.fetchData(url: url) { (result: Result<RepoInfo, APIServiceError>) in
                switch result {
                case .success(let response):                    
                    completion(.success(response.createdAt))
                case .failure:
                    completion(.failure(.apiError))
                }
            }
        }
    }
}
