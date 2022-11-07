//
//  DataLoadingController.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 11/6/22.
//

import UIKit
import SafariServices

class DataLoadingController : UIViewController {
    
    var containerView: UIView!
    
    func presentAlertOnMainThread(title: String, message: String, button: String) {
        DispatchQueue.main.async {
            let controller = AlertController(title: title, message: message, button: button)
            controller.modalPresentationStyle = .overFullScreen
            controller.modalTransitionStyle = .crossDissolve
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let indicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(indicator)
        
        indicator.centerX(inView: containerView)
        indicator.centerY(inView: containerView)
        
        indicator.startAnimating()
        
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showSafariController(with url: URL) {
        let safariController = SFSafariViewController(url: url)
        safariController.preferredControlTintColor = .systemGreen
        present(safariController, animated: true)
    }
    
    func showEmptyState(with message: String, in view: UIView) {
        let emptyState = EmptyStateView(message: message)
        emptyState.frame = view.bounds
        view.addSubview(emptyState)
    }
    
}
