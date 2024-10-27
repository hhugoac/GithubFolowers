//
//  FollowersViewModel.swift
//  Githubfollowers
//
//  Created by Hugo Alonzo on 26/10/24.
//

import UIKit

protocol FollowersViewModelProtocol: AnyObject {
    func didSelectFollower(_ follower: Follower)
    func didLoadMoreFollowers()
    
}

/// ViewModel to load follower of a user
final class FollowersViewModel {
    
    private var searchText = ""
    public weak var delegate: FollowersViewModelProtocol?
    private var followers: [Follower] = []
    
    private var cellViewModels: [UICollectionViewCell] = []
    
    func executeSearch()  {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        var pathComponet: [String] = [searchText, "followers"]
        
        let request = GFRequest(endpoint: .users, pathComponents: pathComponet)
        
        HttpClient.shared.execute(
            request, expecing: [Follower].self
        ) { [weak self] result in
            switch result {
            case .success(let followers):
                print(String(describing: followers))
                DispatchQueue.main.async {
                    self?.followers = followers
                }
            case .failure(let error):
                print(String(describing: error))
                //break
            }
        }
    }
    
    func set(query text: String) {
        self.searchText = text
    }
}

extension FollowersViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell", for: indexPath
        ) as? UICollectionViewCell else {
            fatalError("Unsupported cell type")
        }
        cell.backgroundColor = .red
        return cell
    }
}
