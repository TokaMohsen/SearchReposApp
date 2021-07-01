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
    
    func setupTableCell(repoName : String , ownerName : String , creationData : String)
    {
        
    }
}
