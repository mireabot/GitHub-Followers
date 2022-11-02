//
//  EmptyState.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/2/22.
//

import UIKit

class EmptyStateView: UIView {
    //MARK: - Properties
    
    private let messageLabel = TitleLabel(alignment: .center, fontSize: 28)
    
    private let logoImage = UIImageView()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configureUI()
    }
    
    
    //MARK: - Helpers
    
    private func configureUI() {
        addSubview(messageLabel)
        addSubview(logoImage)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        messageLabel.centerY(inView: self, constant: -150)
        messageLabel.leading(inView: self, leadingValue: 40, trailingValue: 40)
        messageLabel.anchor(height: 200)
        
        logoImage.image = UIImage(named: "empty-state-logo")
        logoImage.setDimensionsWithMultiplier(width: self.widthAnchor, height: self.heightAnchor, value: 1.3)
        logoImage.leading(inView: self, leadingValue: 0, trailingValue: 170)
        logoImage.anchor(bottom: self.bottomAnchor, paddingBottom: 40)
    }
}
