//
//  InfoView.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/4/22.
//

import UIKit

enum ItemInfoType {
    case repos
    case gists
    case followers
    case following
}

class CardInfoView: UIView {
    //MARK: - Properties
    
    private let imageView = UIImageView()
    
    private let titleLabel = TitleLabel(alignment: .left, fontSize: 14)
    
    private let countLabel = TitleLabel(alignment: .center, fontSize: 14)
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor   = .label
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
    }
    
    func setType(type: ItemInfoType, with count: Int) {
        switch type {
        case .repos:
            imageView.image = UIImage(systemName: "folder")
            titleLabel.text = "GitHub Repos"
        case .gists:
            imageView.image = UIImage(systemName: "note.text")
            titleLabel.text = "GitHub Gists"
        case .followers:
            imageView.image = UIImage(systemName: "person.2")
            titleLabel.text = "Followers"
        case .following:
            imageView.image = UIImage(systemName: "person.2.wave.2")
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
    }
}
