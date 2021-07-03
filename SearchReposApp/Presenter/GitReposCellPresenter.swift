//
//  GitReposCellPresenter.swift
//  SearchReposApp
//
//  Created by toka mohsen on 03/07/2021.
//

import Foundation

protocol GitReposCellPresenterDelegate: NSObject {
    func updateCreationDate(date: String)
}

class GitReposCellPresenter{
    private let infoService: GetOwnerInfoService
    private let repo: RepoDetails
    private weak var viewDelegate: GitReposCellPresenterDelegate?
    
    init(service:GetOwnerInfoService, repoDetails: RepoDetails) {
        self.infoService = service
        self.repo = repoDetails
    }
    
    func setViewDelegate(_ delegate: GitReposCellPresenterDelegate) {
        self.viewDelegate = delegate
    }
    
    func fetchCreationDate()
    {
        infoService.getRepoCreationDate(from: repo.url) { [weak self] (result) in
            guard let self = self else {return}
    
            switch result {
            case .success(let response):
                self.viewDelegate?.updateCreationDate(date: response)
                
            case .failure:
                break
            }
        }
    }
    
    var repoName: String {
        return repo.fullName
    }
    
    var ownerName: String {
        return repo.owner.login
    }
    
    var imageURL: String {
        return repo.owner.avatarURL
    }
}
