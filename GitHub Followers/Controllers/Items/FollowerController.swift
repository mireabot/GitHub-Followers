//
//  FollowerController.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/5/22.
//

import UIKit

class FollowerController: ItemInfoController {
    //MARK: - Properties
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureElements()
    }
    
    //MARK: - Helpers
    
    private func configureElements() {
        firstView.setType(type: .followers, with: user.followers)
        secondView.setType(type: .following, with: user.following)
        
        actionButton.setBackground(backgroundColor: .systemGreen, title: "Open Followers List")
    }
}

