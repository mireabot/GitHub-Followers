//
//  AvatarImage.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/1/22.
//

import UIKit

class AvatarImage : UIImageView {
    //MARK: - Properties
    
    private let placeholder = UIImage(named: "avatar-placeholder")!
    
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
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholder
    }
}
