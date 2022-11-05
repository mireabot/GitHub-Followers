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
    private let firstView = UIView()
    private let secondView = UIView()
    private let dateLabel = BodyLabel(alignment: .center)
    
    var views: [UIView] = []
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem = done
        
        createUI()
        setConstraints()
        fetchInfo()
    }
    
    //MARK: - Helpers
    
    func fetchInfo() {
        showLoadingView()
        Networkmanager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(child: ProfileHeader(user: user), to: self.headerView)
                    self.add(child: ReposController(user: user), to: self.firstView)
                    self.add(child: FollowerController(user: user), to: self.secondView)
                    self.dateLabel.text = "GitHub user since \(user.createdAt.convertToDisplayFormat())"
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
    //MARK: - UI
    
    func createUI() {
        views = [headerView, firstView, secondView, dateLabel]
        for item in views {
            view.addSubview(item)
        }
        
        headerView.backgroundColor = .systemBackground
        firstView.backgroundColor = .systemBackground
        secondView.backgroundColor = .systemBackground
    }
    
    func setConstraints() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        views = [headerView, firstView, secondView, dateLabel]
        
        for itemView in views {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            firstView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            firstView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: padding),
            secondView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
        
    }
    
    //MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
