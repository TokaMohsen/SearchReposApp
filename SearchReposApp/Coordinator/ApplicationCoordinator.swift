//
//  ApplicationCoordinator.swift
//  SearchReposApp
//
//  Created by toka mohsen on 03/07/2021.
//

import UIKit

class ApplicationCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let service = GetGithubRepoListService()
        let presenter = RepoListPresenter(coordinator: self, service: service)
        let viewController = ReposListViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension ApplicationCoordinator: RepoListCoordinatorProtocol {
    func navigateToDetails(with details: RepoDetailsUIModel) {
        let presenter = RepoDetailsPresenter(repoDetailsModel: details)
        let viewController = RepoDetailsViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: true)
    }
}
