//
//  SearchViewController.swift
//  Githubfollowers
//
//  Created by Hector Hugo Alonzo Cortez on 25/10/24.
//

import UIKit

class SearchViewController: UIViewController, SearchViewDelegate {

    let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        searchView.delegate = self
        setupView()
    }
    
    func setupView() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func search(username: String) {
        let vc = FollowersViewController()
        vc.title = "Followers of \(username)"
        vc.username = username
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
