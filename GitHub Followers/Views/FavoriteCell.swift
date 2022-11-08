//
//  FavoriteCell.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/6/22.
//

import UIKit

class FavoriteCell : UITableViewCell {
    //MARK: - Properties
    
    var followerData: Follower?
    
    static let favoriteCellID = "FavoriteCell"
    
    private let avatarImage = AvatarImage(frame: .zero)
    
    private let usernameLabel = TitleLabel(alignment: .left, fontSize: 24)
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavorite(favorite: Follower) {
        usernameLabel.text = favorite.login
        Networkmanager.shared.downloadImage(from: favorite.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImage.image = image }
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        addSubviews(avatarImage, usernameLabel)
        accessoryType = .disclosureIndicator
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding12),
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding12),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

