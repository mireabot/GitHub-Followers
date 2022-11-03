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
    
    var user: User!
    
    private let headerView = UIView()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem = done
        navigationItem.title = username
        
        createUI()
        fetchInfo()
    }
    
    //MARK: - Helpers
    
    func fetchInfo() {
        Networkmanager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(child: ProfileHeader(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentControllerOnMainThread(title: "Something went wrong", message: error.rawValue, button: "Ok")
            }
        }
    }
    
    func add(child: UIViewController, to container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.frame = container.bounds
        child.didMove(toParent: self)
    }
    
    func createUI() {
        view.addSubview(headerView)
        
        headerView.backgroundColor = .systemBackground
        
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, height: 180)
        headerView.leading(inView: view, leadingValue: padding20, trailingValue: padding20)
    }
    
    //MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
