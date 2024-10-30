//
//  FollowersViewController.swift
//  Githubfollowers
//
//  Created by Hector Hugo Alonzo Cortez on 25/10/24.
//

import UIKit

class FollowersViewController: UIViewController {
    var username : String?
    private let followersListView = FollowersListView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(followersListView)
        addConstraints()
        if let username = username {
            
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            followersListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            followersListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            followersListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            followersListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
