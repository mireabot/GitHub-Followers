//
//  SearchController.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 10/30/22.
//

import UIKit

class SearchController: UIViewController {
    //MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gh-logo")
        iv.setDimensions(width: 200, height: 200)
        return iv
    }()
    
    private let usernameTextField = ReusableTextField()
    
    private let serviceButton : ReusableButton = {
        let button = ReusableButton(background: .systemGreen, title: "Get followers")
        button.addTarget(self, action: #selector(handlePassData), for: .touchUpInside)
        
        return button
    }()
    
    var isUsernameEmpty: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureUI()
        createDismissGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubview(logoImageView)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 100)
        logoImageView.centerX(inView: view)
        
        view.addSubview(usernameTextField)
        usernameTextField.anchor(top: logoImageView.bottomAnchor, paddingTop: 48, height: 50)
        usernameTextField.leading(inView: view, leadingValue: 50, trailingValue: 50)
        usernameTextField.centerX(inView: view)
        usernameTextField.delegate = self
        
        view.addSubview(serviceButton)
        serviceButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 48, paddingBottom: 50, height: 50)
        serviceButton.leading(inView: view, leadingValue: 50, trailingValue: 50)
        serviceButton.centerX(inView: view)
        
    }
    
    func createDismissGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Selectors
    
    @objc func handlePassData() {
        let controller = FollowersController()
        guard isUsernameEmpty else {
            print("DEBUG: No username")
            return
        }
        
        controller.username = usernameTextField.text
        controller.title = usernameTextField.text
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
