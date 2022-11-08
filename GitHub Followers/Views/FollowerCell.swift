//
//  FollowerCell.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/1/22.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    //MARK: - Properties
    
    var followerData: Follower?
    
    static let followerCellID = "FollowerCell"
    
    private let avatarImage = AvatarImage(frame: .zero)
    
    private let usernameLabel = TitleLabel(alignment: .center, fontSize: 16)
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        
        Networkmanager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImage.image = image }
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        addSubviews(avatarImage, usernameLabel)
        
        avatarImage.anchor(top: topAnchor, paddingTop: padding8)
        avatarImage.leading(inView: self, with: padding8)
        avatarImage.trailing(inView: self, with: padding8)
        avatarImage.sizeConstaits(height: avatarImage.widthAnchor)
        
        usernameLabel.anchor(top: avatarImage.bottomAnchor, paddingTop: 12, height: 20)
        usernameLabel.leading(inView: self, with: padding8)
        usernameLabel.trailing(inView: self, with: padding8)
    }
}
