//
//  SeaCreatureViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit
import Combine

final class SeaCreatureViewController: UIViewController {
    
    private let seaCreatureViewModel = SeaCreatureViewModel()
    private var cancellables = Set<AnyCancellable>()
    private lazy var seaCreatureCollectionView: UICollectionView = {
        let collectionView = CreatureCollectionView()
        collectionView.register(SeaCreatureCollectionViewCell.self, forCellWithReuseIdentifier: "SeaCreaturesCell")
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
        setCollectionViewBackground()
        bindViewModel()
        seaCreatureViewModel.loadCreature()
    }
}

private extension SeaCreatureViewController {
    func setCollectionViewBackground() {
        guard let blueRoyal = UIColor(named: "ColorBlueRoyal")?.cgColor,
              let blueNight = UIColor(named: "ColorBlueNight")?.cgColor else { return }
        let colors = [blueRoyal, blueNight, UIColor.black.cgColor]
        view.setCollectionViewBackground(collectionView: seaCreatureCollectionView, colors: colors)
    }
    
    func bindViewModel() {
        seaCreatureViewModel.failureHandler
            .sink { [weak self] error in
                guard let self else { return }
                errorView.isHidden = false
            }
            .store(in: &seaCreatureViewModel.cancellables)
        
        seaCreatureViewModel.reloadData
            .sink { [weak self] in
                guard let self else { return }
                seaCreatureCollectionView.reloadData()
            }
            .store(in: &seaCreatureViewModel.cancellables)
    }
    
    func addSubviews() {
        view.addSubview(seaCreatureCollectionView)
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            seaCreatureCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            seaCreatureCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seaCreatureCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seaCreatureCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - ReloadDataDelegate

extension SeaCreatureViewController: ReloadDataDelegate {
    func reloadData() {
        seaCreatureCollectionView.reloadData()
    }
}

// MARK: - ErrorToastable

extension SeaCreatureViewController: ErrorToastable {
    func showDatabaseError(with text: String) {
        self.showToast(with: text)
    }
}

// MARK: - CollectionViewDataSource

extension SeaCreatureViewController: UICollectionViewDataSource {
    
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
        cancellables.removeAll()
        headerView.configureHeaderLabel(with: seaCreatureViewModel.header)
        headerView.switchButtonAction
            .sink { [weak self] in
                guard let self else { return }
                seaCreatureViewModel.isShowingNorthCreature.toggle()
                collectionView.reloadData()
            }
            .store(in: &cancellables)
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
        seaCreatureViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let seaCreatureCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SeaCreaturesCell",
            for: indexPath
        ) as? SeaCreatureCollectionViewCell else { return UICollectionViewCell() }
        let seaCreature = seaCreatureViewModel.makeSeaCreature(with: indexPath.row)
        let seaCreatureCollectionViewCellViewModel = SeaCreatureCollectionViewCellViewModel(seaCreatureData: seaCreature)
        seaCreatureCell.configureCell(with: seaCreatureCollectionViewCellViewModel, view: self)
        return seaCreatureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = SeaCreatureDetailsViewController()
        let selectedSeaCreature = seaCreatureViewModel.makeSeaCreature(with: indexPath.row)
        let seaCreatureDetailsViewModel = SeaCreaturesDetailsViewModel(seaCreatureData: selectedSeaCreature)
        detailsViewController.seaCreaturesDetailsViewModel = seaCreatureDetailsViewModel
        detailsViewController.reloadDataDelegate = self
        self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
    }
}
