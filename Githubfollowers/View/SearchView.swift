//
//  SearchView.swift
//  Githubfollowers
//
//  Created by Hector Hugo Alonzo Cortez on 25/10/24.
//

import UIKit
protocol SearchViewDelegate: AnyObject {
    func search(username: String)
}
class SearchView: UIView {
    
    public weak var delegate:SearchViewDelegate?
    
    let imageLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gh-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        
        textField.textColor = .label
        textField.tintColor = .label
        textField.textAlignment = .center
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 12
        
        textField.backgroundColor = .tertiarySystemBackground
        textField.autocorrectionType = .no
        textField.returnKeyType = .go
        textField.placeholder = "Enter a username"
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let getFollowersButton: UIButton = {
        let button = UIButton()
        let title =  "Get Followers"
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    var isUsernameEntered: Bool {
        return !searchTextField.text!.isEmpty
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        searchTextField.delegate = self
        getFollowersButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        addSubview(imageLogoImageView)
        addSubview(searchTextField)
        addSubview(getFollowersButton)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:))))
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            imageLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageLogoImageView.heightAnchor.constraint(equalToConstant: 200),
            imageLogoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            searchTextField.topAnchor.constraint(equalTo: imageLogoImageView.bottomAnchor, constant: 40),
            searchTextField.rightAnchor.constraint(equalTo: imageLogoImageView.rightAnchor, constant: 50),
            searchTextField.leftAnchor.constraint(equalTo: imageLogoImageView.leftAnchor, constant: -50),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            
            getFollowersButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -70),
            getFollowersButton.leftAnchor.constraint(equalTo: imageLogoImageView.leftAnchor),
            getFollowersButton.rightAnchor.constraint(equalTo: imageLogoImageView.rightAnchor),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc
    func tapButton() {
        guard isUsernameEntered, let searchText = searchTextField.text
        else { return }
        delegate?.search(username: searchText)
    }
}

// MARK: - UITextFieldDelegate

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard isUsernameEntered, let searchText = searchTextField.text
        else { return true }
        
        delegate?.search(username: searchText)
        return true
    }
}
