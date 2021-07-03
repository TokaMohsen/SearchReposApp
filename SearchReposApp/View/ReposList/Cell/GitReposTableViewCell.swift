//
//  GitReposTableViewCell.swift
//  SearchReposApp
//
//  Created by toka mohsen on 01/07/2021.
//

import Foundation
import UIKit

class GitReposTableViewCell : UITableViewCell {
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    static let cellNib = UINib(nibName: "GitReposTableViewCell", bundle: nil)
    static let cellId = "GitReposTableViewCellId"

    func setupTableCell(with presenter: GitReposCellPresenter)
    {
        presenter.setViewDelegate(self)
        presenter.fetchCreationDate()
        
        self.repoNameLabel.text = presenter.repoName
        self.ownerNameLabel.text = presenter.ownerName
        self.repoImageView.downloadImage(from: presenter.imageURL)
    }
}

extension GitReposTableViewCell: GitReposCellPresenterDelegate {
    func updateCreationDate(date: String)
    {
        DispatchQueue.main.async {
            self.creationDateLabel.text = date
        }
    }
}
