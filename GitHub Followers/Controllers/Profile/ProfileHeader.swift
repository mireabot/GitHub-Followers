//
//  ProfileHeader.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/3/22.
//

import UIKit

class ProfileHeader: UIViewController {
    //MARK: - Properties
    
    private let avatarImage = AvatarImage(frame: .zero)
    
    private let usernameLabel = TitleLabel(alignment: .left, fontSize: 34)
    private let nameLabel = SecondaryLabel(size: 18)
    
    private let locationImage = UIImageView()
    private let locationLabel = SecondaryLabel(size: 18)
    
    private let bioLabel = BodyLabel(alignment: .left)
    
    var user: User!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        addSubViews()
        createLayout()
        
        Networkmanager.shared.downloadImage(from: user.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImage.image = image }
        }
        
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? "No name"
        locationLabel.text = user.location ?? " No location"
        
        locationImage.image = UIImage(systemName: "location.circle")
        locationImage.tintColor = .systemGreen
        locationImage.setDimensions(width: 20, height: 20)
        
        bioLabel.text = user.bio ?? "No bio"
        bioLabel.numberOfLines = 3
    }
    
    func addSubViews() {
        view.addSubviews(avatarImage, usernameLabel, nameLabel, locationImage, locationLabel, bioLabel)
    }
    
    func createLayout() {
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: padding20),
            avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 90),
            avatarImage.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: padding12),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: padding12),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImage.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor),
            locationImage.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: padding12),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: padding12),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
}
