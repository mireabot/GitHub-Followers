//
//  Button.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 10/30/22.
//

import UIKit

class ReusableButton: UIButton {
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(background: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = background
        self.setTitle(title, for: .normal)
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
