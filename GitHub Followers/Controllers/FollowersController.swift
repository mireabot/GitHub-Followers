//
//  FollowersController.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 10/30/22.
//

import UIKit

class FollowersController: UIViewController {
    //MARK: - Properties
    
    enum Section { case main }
    
    var username: String!
    var collectionView: UICollectionView!
    var dataSourse: UICollectionViewDiffableDataSource<Section, Follower>!
    var page: Int = 1
    var hasMoreFollowers = true
    
    var followers: [Follower] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollection()
        fetchFollowers(username: username, page: page)
        configureDataSourse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Helpers
    
    func fetchFollowers(username: String, page: Int) {
        showLoadingView()
        Networkmanager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 50 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have followers 🥲"
                    DispatchQueue.main.async { self.showEmptyState(with: message, in: self.view) }
                    return
                }
                
                self.updateData()
                
            case .failure(let error):
                self.presentControllerOnMainThread(title: "Bad result", message: error.rawValue, button: "Close")
            }
        }
    }
    //MARK: - UICollectionViewFlowLayout
    func configureCollection() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCustomFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.followerCellID)
    }
    
    //MARK: - UICollectionViewDiffableDataSource
    func configureDataSourse() {
        dataSourse = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.followerCellID, for: indexPath) as! FollowerCell
            
            cell.set(follower: itemIdentifier)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSourse.apply(snapshot, animatingDifferences: true)
        }
    }
}

//MARK: - UICollectionViewDelegate

extension FollowersController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            fetchFollowers(username: username, page: page)
        }
    }
}
