//
//  SearchController.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 10/30/22.
//

import UIKit

class SearchController: DataLoadingController {
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
    
    var logoImageTopAnchor: NSLayoutConstraint!
    
    var isUsernameEmpty: Bool { return !usernameTextField.text!.isEmpty }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureUI()
        createDismissGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubviews(logoImageView, usernameTextField, serviceButton)
        
        logoImageView.centerX(inView: view)
        
        let top: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        logoImageTopAnchor = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top)
        logoImageTopAnchor.isActive = true
        
        usernameTextField.anchor(top: logoImageView.bottomAnchor, paddingTop: 48, height: 50)
        usernameTextField.leading(inView: view, with: 50)
        usernameTextField.trailing(inView: view, with: 50)
        usernameTextField.centerX(inView: view)
        usernameTextField.delegate = self
        
        serviceButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 48, paddingBottom: 50, height: 50)
        serviceButton.leading(inView: view, with: 50)
        serviceButton.trailing(inView: view, with: 50)
        serviceButton.centerX(inView: view)
        
    }
    
    func createDismissGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Selectors
    
    @objc func handlePassData() {
        let controller = FollowersController(username: usernameTextField.text!)
        guard isUsernameEmpty else {
            presentAlertOnMainThread(title: "Empty username", message: "We need username to find something!", button: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
