//
//  SecondaryLabel.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/3/22.
//

import UIKit

class SecondaryLabel: UILabel {
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    init(size: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size, weight: .medium)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
    }
}
