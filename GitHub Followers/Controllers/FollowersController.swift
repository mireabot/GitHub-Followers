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
    
    var followers: [Follower] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollection()
        fetchFollowers()
        configureDataSourse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Helpers
    
    func fetchFollowers() {
        Networkmanager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let followers):
                print("Followers count = \(followers.count)")
                self.followers = followers
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
