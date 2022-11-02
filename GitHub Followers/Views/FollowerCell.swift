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
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        addSubview(avatarImage)
        addSubview(usernameLabel)
        
        avatarImage.anchor(top: contentView.topAnchor, paddingTop: padding8)
        avatarImage.leading(inView: contentView, leadingValue: padding8, trailingValue: padding8)
        avatarImage.sizeConstaits(height: avatarImage.widthAnchor)
        
        usernameLabel.anchor(top: avatarImage.bottomAnchor, paddingTop: 12, height: 20)
        usernameLabel.leading(inView: contentView, leadingValue: padding8, trailingValue: padding8)
    }
}
