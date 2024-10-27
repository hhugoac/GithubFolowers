//
//  FollowersListView.swift
//  Githubfollowers
//
//  Created by Hugo Alonzo on 27/10/24.
//

import UIKit

protocol FollowersListViewProtocol: AnyObject {
    func updateUsername(username:String)
    func followerListView(
        _ followerListView: FollowersListView,
        didSelectFollower follower: Follower
    )
}

class FollowersListView: UIView {

    private let viewModel = FollowersViewModel()
    private var delegate: FollowersListViewProtocol?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        addConstraints()
        viewModel.delegate = self
        loadInitialValues()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func loadInitialValues() {
        delegate?.setInitialValues(username: <#T##String#>)
        viewModel.set(query: "")
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
}

extension FollowersListView: FollowersViewModelProtocol {
    func didSelectFollower(_ follower: Follower) {
        // 📝 TODO:  conect here to de next view
        print(String(describing: follower))
    }
    
    func didLoadMoreFollowers() {
        // 📝 TODO:  paging proces here
    }
    
    
}

