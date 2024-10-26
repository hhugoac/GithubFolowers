//
//  FollowersViewController.swift
//  Githubfollowers
//
//  Created by Hector Hugo Alonzo Cortez on 25/10/24.
//

import UIKit

class FollowersViewController: UIViewController {
    var username : String?
    let viewModel = FollowersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = username {
            viewModel.set(query: username)
            viewModel.executeSearch()
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
