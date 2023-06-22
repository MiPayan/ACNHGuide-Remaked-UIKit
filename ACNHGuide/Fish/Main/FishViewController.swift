//
//  FishViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit
import SkeletonView
import RealmSwift
import Combine

final class FishViewController: UIViewController {
    
    private let fishViewModel = FishViewModel()
    private lazy var fishCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            CreatureCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "AdaptiveHeader"
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FishCollectionViewCell.self, forCellWithReuseIdentifier: "FishCell")
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var errorView: UIView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpCollectionViewBackground()
        bindViewModel()
        fishViewModel.loadFishesData()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNetworkConnectivityChange(notification:)),
            name: Notification.Name("NetworkConnectivityDidChange"),
            object: nil
        )
    }
    
    @objc private func handleNetworkConnectivityChange(notification: Notification) {
        guard let isNetworkAvailable = notification.userInfo?["isNetworkAvailable"] as? Bool else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            errorView.isHidden = isNetworkAvailable
            if isNetworkAvailable {
                fishViewModel.loadFishesData()
                fishCollectionView.reloadData()
            }
        }
    }
}

private extension FishViewController {
    func bindViewModel() {
        fishViewModel.failureHandler
            .sink { [weak self] error in
                guard let self else { return }
                errorView.isHidden = false
            }
            .store(in: &fishViewModel.cancellables)
        
        fishViewModel.reloadData
            .sink { [weak self] _ in
                guard let self else { return }
                fishCollectionView.reloadData()
            }
            .store(in: &fishViewModel.cancellables)
    }
    
    func setUpCollectionViewBackground() {
        guard let blueOcean = UIColor(named: "ColorBlueOcean")?.cgColor,
              let blueRoyal = UIColor(named: "ColorBlueRoyal")?.cgColor else {
            return
        }
        let colors = [blueOcean, blueRoyal]
        view.setCollectionViewBackground(collectionView: fishCollectionView, colors: colors)
    }
    
    func addSubviews() {
        view.addSubview(fishCollectionView)
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            fishCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            fishCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fishCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fishCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - ReloadDataDelegate

extension FishViewController: ReloadDataDelegate {
    func reloadData() {
        fishCollectionView.reloadData()
    }
}

// MARK: - ErrorToastable

extension FishViewController: ErrorToastable {
    func showDatabaseError(with text: String) {
        self.showToast(with: text)
    }
}

// MARK: - CollectionViewDataSource

extension FishViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        "FishCell"
    }
    
    // Header.
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "AdaptiveHeader",
            for: indexPath
        ) as? CreatureCollectionReusableView else { return UICollectionReusableView() }
        headerView.configureHeaderLabel(with: fishViewModel.configureHeaderSection(with: indexPath.section))
        return headerView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: view.frame.width, height: 40.0)
    }
    
    // Configure cells.
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        fishViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fishViewModel.configureSectionCollectionView(with: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fishCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FishCell",
            for: indexPath
        ) as? FishCollectionViewCell else { return UICollectionViewCell() }
        let fish = fishViewModel.makeFish(with: indexPath.section, index: indexPath.row)
        let fishCollectionViewCellViewModel = FishCollectionViewCellViewModel(fishData: fish)
        fishCell.configureCell(with: fishCollectionViewCellViewModel, view: self)
        return fishCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = FishDetailsViewController()
        let selectedFish = fishViewModel.makeFish(with: indexPath.section, index: indexPath.row)
        let fishDetailsViewModel = FishDetailsViewModel(fishData: selectedFish)
        detailsViewController.fishDetailsViewModel = fishDetailsViewModel
        detailsViewController.reloadDataDelegate = self
        self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
    }
}
