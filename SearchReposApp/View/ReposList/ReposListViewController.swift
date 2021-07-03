//
//  ReposListViewController.swift
//  SearchReposApp
//
//  Created by toka mohsen on 01/07/2021.
//

import Foundation
import UIKit

class ReposListViewController : UIViewController{
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    private let presenter : RepoListPresenter
    
    // MARK: - Initialization
    init(presenter: RepoListPresenter) {
        self.presenter = presenter
        super.init(nibName: "ReposListViewController" , bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        presenter.setView(view : self)
        setupView()
        
        presenter.loadRepos()
    }
    
    // MARK: - Helpers Methods
    private func setupView() {
        searchBar.delegate = self

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(GitReposTableViewCell.cellNib, forCellReuseIdentifier: GitReposTableViewCell.cellId)
    }

    @objc func refresh() {
        presenter.loadRepos()
    }
}

extension ReposListViewController : UITableViewDelegate , UITableViewDataSource , UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numOfRepos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GitReposTableViewCell.cellId, for: indexPath) as? GitReposTableViewCell else {
            return UITableViewCell()
        }
        
        if let model = presenter.makeRepoCellUIModel(at: indexPath.row) {
            cell.setupTableCell(repo: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectedRepo(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        hideLoadingIndicator()
        if indexPaths.last?.row ?? 0 >= presenter.numOfRepos - 5 {
            presenter.loadRepos()
        }
    }
}

extension ReposListViewController: RepoListViewProtocol{
    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func showNoDataView()
    {
        self.noDataView.isHidden = false
        self.tableView.isHidden = true
    }
    
    
    func showErrorView() {
        let alertController = UIAlertController(title: "Error", message: "Invalid Operation", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoadingIndicator()
   {
        activityIndicator.isHidden = false
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
    }
    
    func OnReposListChanged()
    {
       
        DispatchQueue.main.async {
            if ((self.tableView.refreshControl?.isRefreshing) != nil){
                self.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }
    
}

extension ReposListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.resetPageIndex()
        if let keyword = searchBar.text, keyword.count >= 2 {
            presenter.searchKeyword = keyword
        }
    }
}
