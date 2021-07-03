//
//  RepoDetailsViewController.swift
//  SearchReposApp
//
//  Created by toka mohsen on 01/07/2021.
//

import Foundation
import UIKit

class RepoDetailsViewController : UIViewController{
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var repoURLLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var repoImageView: UIImageView!
    
    private let presenter : RepoDetailsPresenter
    init(presenter: RepoDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: "RepoDetailsViewController" , bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.setupRepoDetails()
    }
    
    private func setupRepoDetails()
    {
        self.repoURLLabel.text = presenter.repoUrl
        self.descriptionLabel.text = presenter.description
        if let imgUrl = presenter.img {
            repoImageView.downloadImage(from: imgUrl)
        }
        else{repoImageView.image = UIImage(named: "unknown")}
        
    }
}
