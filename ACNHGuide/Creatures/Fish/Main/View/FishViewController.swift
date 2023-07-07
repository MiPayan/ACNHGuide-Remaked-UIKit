//
//  FishViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit
import RealmSwift
import Combine

final class FishViewController: UIViewController {
    
    private let fishViewModel = FishViewModel()
    private var cancellables = Set<AnyCancellable>()
    private lazy var fishCollectionView: UICollectionView = {
        let collectionView = CreatureCollectionView()
        collectionView.register(FishCollectionViewCell.self, forCellWithReuseIdentifier: "FishCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpCollectionViewBackground()
        bindViewModel()
        fishViewModel.loadCreature()
    }
}

private extension FishViewController {
    func bindViewModel() {
        fishViewModel.failureHandler
            .sink { [weak self] error in
                guard let self else { return }
                errorView.isHidden = false
            }
            .store(in: &cancellables)
        
        fishViewModel.reloadData
            .sink { [weak self] _ in
                guard let self else { return }
                fishCollectionView.reloadData()
            }
            .store(in: &cancellables)
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

extension FishViewController: UICollectionViewDataSource {
    
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
        headerView.configureHeaderLabel(with: fishViewModel.header)
        headerView.cancellables.removeAll()
        headerView.switchButtonAction
            .sink { [weak self] in
                guard let self else { return }
                fishViewModel.isShowingNorthCreature.toggle()
                collectionView.reloadData()
            }
            .store(in: &headerView.cancellables)
        return headerView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fishViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fishCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FishCell",
            for: indexPath
        ) as? FishCollectionViewCell else { return UICollectionViewCell() }
        let fish = fishViewModel.makeFish(with: indexPath.row)
        let fishCollectionViewCellViewModel = FishCollectionViewCellViewModel(fishData: fish)
        fishCell.configureCell(with: fishCollectionViewCellViewModel, view: self)
        return fishCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = FishDetailsViewController()
        let selectedFish = fishViewModel.makeFish(with: indexPath.row)
        let fishDetailsViewModel = FishDetailsViewModel(fishData: selectedFish)
        detailsViewController.fishDetailsViewModel = fishDetailsViewModel
        detailsViewController.reloadDataDelegate = self
        self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
    }
}
