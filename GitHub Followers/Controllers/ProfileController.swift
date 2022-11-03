//
//  ProfileController.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/3/22.
//

import UIKit

class ProfileController: UIViewController {
    //MARK: - Properties
    
    var username: String!
    
    var user: User?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem = done
        navigationItem.title = username
        
        fetchInfo()
    }
    
    //MARK: - Helpers
    
    func fetchInfo() {
        Networkmanager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user.bio)
            case .failure(let error):
                self.presentControllerOnMainThread(title: "Something went wrong", message: error.rawValue, button: "Ok")
            }
        }
    }
    
    //MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
