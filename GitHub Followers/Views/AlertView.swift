//
//  AlertView.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/6/22.
//

import UIKit

class AlertView: UIView {
    //MARK: - Properties
    
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
        backgroundColor = .systemBackground
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
}
