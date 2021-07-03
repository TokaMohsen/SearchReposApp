//
//  RepoDetailsPresenter.swift
//  SearchReposApp
//
//  Created by toka mohsen on 03/07/2021.
//

import Foundation

class RepoDetailsPresenter {
    private let repoDetailsModel : RepoDetailsUIModel
    
    init(repoDetailsModel: RepoDetailsUIModel ) {
        self.repoDetailsModel = repoDetailsModel
    }
    
    var description: String?
    {
        return repoDetailsModel.description
    }
    var repoUrl: String?
    {
        return repoDetailsModel.repoUrl
    }
    var img: URL?
    {
        return URL(string: repoDetailsModel.img ?? "")
    }
}
