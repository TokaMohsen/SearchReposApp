//
//  GetGithubRepoListService.swift
//  SearchReposApp
//
//  Created by toka mohsen on 01/07/2021.
//

import Foundation

class GetGithubRepoListService {
    let responseCache = NSCache<NSString, AnyObject>()
    
    var array: [String] = []
    
    public func fetchRepos(searchKeyword: String?, page: Int, numberOfItems: Int, completion: @escaping (Result<[RepoDetails], APIServiceError>) -> Void) {
        
        if let reposFromCache = responseCache.object(forKey: "repoJsonFileName") as? RepoList {
            let repos = getRepos(with: reposFromCache.repoList, searchKeyword: searchKeyword, page: page, numberOfItems: numberOfItems)
            completion(.success(repos))
        }
        else{
            APIClient<[RepoDetails]>.fetchData(url: URL(string: Endpoints.GitHub.rawValue)!) { [weak self] (result: Result<[RepoDetails], APIServiceError>) in
                guard let self = self else {return}

                switch result {
                case .success(let response):
                    let reposList = RepoList(repos: response)
                    self.responseCache.setObject(reposList , forKey: "repoJsonFileName" )
                    
                    let repos = self.getRepos(with: response, searchKeyword: searchKeyword, page: page, numberOfItems: numberOfItems)
                    completion(.success(repos))
                case .failure:
                    completion(.failure(.apiError))
                }
            }
        }
    }
    
    func getRepos(with list: [RepoDetails], searchKeyword: String?, page: Int, numberOfItems: Int) -> [RepoDetails] {
        var filterdList = list
        if let search = searchKeyword?.trimmingCharacters(in: .whitespacesAndNewlines), !search.isEmpty {
            filterdList = list.filter({ $0.name.localizedCaseInsensitiveContains(search)})
        }

        var  start = (page * numberOfItems) - numberOfItems
        start = filterdList.count < start ? filterdList.count : start
        var end = page * numberOfItems
        end = filterdList.count < end ? filterdList.count : end
        
        return Array(filterdList[start..<end])
    }
}
