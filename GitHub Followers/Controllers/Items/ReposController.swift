//
//  ReposController.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/4/22.
//

import UIKit

class ReposController: ItemInfoController {
    //MARK: - Properties
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureElements()
    }
    
    //MARK: - Helpers
    
    private func configureElements() {
        firstView.setType(type: .repos, with: user.publicRepos)
        secondView.setType(type: .gists, with: user.publicGists)
        
        actionButton.setBackground(backgroundColor: .systemPurple, title: "Open GitHub Profile")
    }
}
