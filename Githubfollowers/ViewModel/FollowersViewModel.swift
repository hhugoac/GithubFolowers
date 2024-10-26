//
//  FollowersViewModel.swift
//  Githubfollowers
//
//  Created by Hugo Alonzo on 26/10/24.
//

import Foundation

/// ViewModel to load follower of a user
final class FollowersViewModel {
    
    private var searchText = ""
    
    func executeSearch()  {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        var pathComponet: [String] = [searchText, "followers"]
        
        let request = GFRequest(endpoint: .users, pathComponents: pathComponet)
        
        HttpClient.shared.execute(request, expecing: [Follower].self) { result in
            switch result {
            case .success(let users):
                print(String(describing: users))
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
