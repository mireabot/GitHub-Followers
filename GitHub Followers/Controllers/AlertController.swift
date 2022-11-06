//
//  AlertController.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/1/22.
//

import UIKit

class AlertController: UIViewController {
    //MARK: - Properties
    
    private let container = AlertView()
    
    private let titleLabel = TitleLabel(alignment: .center, fontSize: 20)
    
    private let messageLabel = BodyLabel(alignment: .center)
    
    private let serviceButton = ReusableButton(background: .systemPink, title: "Ok")
    
    var alertText: String?
    var messageText: String?
    var buttonText: String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.alertBackground
        configureUI()
    }
    
    init(title: String, message: String, button: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertText = title
        self.messageText = message
        self.buttonText = button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(container)
        
        container.center(inView: view)
        container.anchor(width: 280, height: 220)
        
        container.addSubview(titleLabel)
        titleLabel.text = alertText ?? "Default Text"
        
        titleLabel.anchor(top: container.topAnchor, paddingTop: 20, height: 28)
        titleLabel.leading(inView: container, with: padding20)
        titleLabel.trailing(inView: container, with: padding20)
        
        container.addSubview(serviceButton)
        serviceButton.setTitle(buttonText ?? "Ok", for: .normal)
        serviceButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
        serviceButton.anchor(bottom: container.bottomAnchor, paddingBottom: 12, height: 44)
        serviceButton.leading(inView: container, with: padding20)
        serviceButton.trailing(inView: container, with: padding20)
        
        container.addSubview(messageLabel)
        messageLabel.text = messageText
        messageLabel.numberOfLines = 4
        
        messageLabel.anchor(top: titleLabel.bottomAnchor, bottom: serviceButton.topAnchor)
        messageLabel.leading(inView: container, with: padding20)
        messageLabel.trailing(inView: container, with: padding20)
        
    }
    
    //MARK: - Selectors
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
