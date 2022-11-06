//
//  FollowersController.swift
//  GitHub Followers
//
//  Created by Mikhail Kolkov on 10/30/22.
//

import UIKit

protocol FollowersControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowersController: UIViewController {
    //MARK: - Properties
    
    enum Section { case main }
    
    var username: String!
    var collectionView: UICollectionView!
    var dataSourse: UICollectionViewDiffableDataSource<Section, Follower>!
    var page: Int = 1
    var hasMoreFollowers = true
    
    var followers: [Follower] = []
    var filterFollowers: [Follower] = []
    
    var isSearching = false
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureSearchController()
        configureCollection()
        fetchFollowers(username: username, page: page)
        configureDataSourse()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Bad result", message: error.rawValue, button: "Close")
            }
        }
    }
    
    //MARK: - Selectors
    @objc func handleAddTapped() {
        Networkmanager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.update(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentAlertOnMainThread(title: "Succsess!", message: "User was added to favorites list.", button: "Ok")
                        return
                    }
                    
                    self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, button: "Ok")
                }
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, button: "Ok")
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
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSourse.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func configureSearchController() {
        let controller = UISearchController()
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        controller.searchBar.placeholder = "Search for username"
        controller.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = controller
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = isSearching ? filterFollowers[indexPath.item] : followers[indexPath.item]
        
        let controller = ProfileController()
        controller.username = follower.login
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true)
    }
}

//MARK: - UISearchResultsUpdating, UISearchBarDelegate

extension FollowersController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filterFollowers = followers.filter({ $0.login.lowercased().contains(filter.lowercased()) })
        updateData(on: filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}


//MARK: - FollowersControllerDelegate

extension FollowersController: FollowersControllerDelegate {
    
    fileprivate func updateCollection(_ username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filterFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        fetchFollowers(username: username, page: page)
    }
    
    func didRequestFollowers(for username: String) {
        updateCollection(username)
    }
}
