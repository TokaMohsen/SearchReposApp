//
//  RepoListPresenter.swift
//  SearchReposApp
//
//  Created by toka mohsen on 02/07/2021.
//

import Foundation

protocol RepoListCoordinatorProtocol {
    func navigateToDetails(with details: RepoDetailsUIModel)
}

protocol RepoListViewProtocol: NSObject {
    func showErrorView()
    func showNoDataView()
    func hideNoDataView()
    func OnReposListChanged()
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

class RepoListPresenter {
    // MARK: - Dependencies
    private weak var viewDelegate: RepoListViewProtocol?
    private let repoService: GetGithubRepoListService
    private let coordinator: RepoListCoordinatorProtocol
    
    // MARK: - Properties
    private var fetchedRepos : [RepoDetails]? {
        didSet {
            viewDelegate?.OnReposListChanged()
        }
    }
    
    var numOfRepos : Int {
        return fetchedRepos?.count ?? 0
    }
    
    private var pageIndex = 0
    private let numberOfItemsPerPage = 10
    
    var searchKeyword: String? {
        didSet {
            loadRepos()
        }
    }
    
    // MARK: - Initialization
    init(coordinator: RepoListCoordinatorProtocol, service: GetGithubRepoListService ) {
        self.repoService = service
        self.coordinator = coordinator
    }
    
    // MARK: - Helpers
    func setView(view: RepoListViewProtocol) {
        self.viewDelegate = view
    }
    
    /// fetch get repos service to load paginated cached repos
    ///
    func loadRepos() {
        pageIndex += 1
        self.viewDelegate?.showLoadingIndicator()
        repoService.fetchRepos(searchKeyword: searchKeyword, page: pageIndex, numberOfItems: numberOfItemsPerPage) { [weak self] (result) in
            guard let self = self else {return}
            
            self.viewDelegate?.hideLoadingIndicator()
            self.viewDelegate?.hideNoDataView()
            switch result {
            case .success(let repos):
                if self.pageIndex == 1 {
                    if repos.count == 0 {
                        self.viewDelegate?.showNoDataView()
                        
                    }
                    self.fetchedRepos = repos
                    
                } else {
                    self.fetchedRepos?.append(contentsOf: repos)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.viewDelegate?.showErrorView()
            }
            
        }
    }
    
    func resetPageIndex() {
        pageIndex = 0
    }
    
    /// Takes an index of selected cell as argument to navigate with to details screen
    ///
    /// - Parameter index
    func selectedRepo(at index: Int)
    {
        if let details = self.makeRepoDetailsUIModel(repo: fetchedRepos?[index]) {
            coordinator.navigateToDetails(with: details)
        }
    }
    
    // MARK: - Factory Methods
    
    /// Takes a repo object argument and extract from it parameters which construct and returns a ui model to show in details screen
    ///
    /// - Parameter repo details object
    /// - Returns: detailsUIModel
    private func makeRepoDetailsUIModel(repo: RepoDetails?) -> RepoDetailsUIModel? {
        guard let details = repo else {
            return nil
        }
        let repoUrl = details.htmlURL
        let description = details.configDescription ?? "description not available"
        let imageUrlValue = details.owner.avatarURL
        return  RepoDetailsUIModel(repoUrl: repoUrl, description: description, img: imageUrlValue)
    }
    
    
    func makeRepoCellPresenter(at index: Int) -> GitReposCellPresenter? {
        guard let repo = fetchedRepos?[index] else {
            return nil
        }
        
        let service = GetOwnerInfoService()
        return GitReposCellPresenter(service: service, repoDetails: repo)
    }
}

