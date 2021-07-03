//
//  GitReposTableViewCell.swift
//  SearchReposApp
//
//  Created by toka mohsen on 01/07/2021.
//

import Foundation
import UIKit

class GitReposTableViewCell : UITableViewCell{
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    static let cellNib = UINib(nibName: "GitReposTableViewCell", bundle: nil)
    static let cellId = "GitReposTableViewCellId"

    func setupTableCell(repo: RepoCellUIModel)
    {
        self.repoNameLabel.text = repo.repoName
        self.ownerNameLabel.text = repo.ownerName
        self.creationDateLabel.text = repo.creationDate
        if let imgUrl = repo.img {
            self.repoImageView.downloadImage(from: imgUrl)
        }
        else{repoImageView.image = UIImage(named: "unknown")}
    }
}
