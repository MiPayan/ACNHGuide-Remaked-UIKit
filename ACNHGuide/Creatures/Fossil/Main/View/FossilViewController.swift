//
//  FossilViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit

final class FossilViewController: UIViewController {
    
    private let fossilViewModel = FossilViewModel()
    private lazy var fossilCollectionView: UICollectionView = {
        let collectionView = CreatureCollectionView()
        collectionView.register(FossilCollectionViewCell.self, forCellWithReuseIdentifier: "FossilCell")
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
        fossilViewModel.loadCreature()
    }
}

private extension FossilViewController {
    func bindViewModel() {
        fossilViewModel.failureHandler
            .sink { [weak self] error in
                guard let self else { return }
                errorView.isHidden = false
            }
            .store(in: &fossilViewModel.cancellables)
        
        fossilViewModel.reloadData
            .sink { [weak self] in
                guard let self else { return }
                fossilCollectionView.reloadData()
            }
            .store(in: &fossilViewModel.cancellables)
    }
    
    func setCollectionViewBackground() {
        guard let brownHeart = UIColor(named: "ColorBrownHeart")?.cgColor else { return }
        let colors = [UIColor.brown.cgColor, brownHeart]
        view.setCollectionViewBackground(collectionView: fossilCollectionView, colors: colors)
    }
    
    func addSubviews() {
        view.addSubview(fossilCollectionView)
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            fossilCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            fossilCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fossilCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fossilCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - ReloadDataDelegate

extension FossilViewController: ReloadDataDelegate {
    func reloadData() {
        fossilCollectionView.reloadData()
    }
}

// MARK: - ErrorToastable

extension FossilViewController: ErrorToastable {
    func showDatabaseError(with text: String) {
        self.showToast(with: text)
    }
}

// MARK: - CollectionViewDataSource

extension FossilViewController: UICollectionViewDataSource {
    
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
        headerView.switchHemisphereButton.isHidden = true
        headerView.configureHeaderLabel(with: fossilViewModel.headerText)
        return headerView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: view.frame.width, height: 40.0)
    }
    
    // Configure cells.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fossilViewModel.creatures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fossils = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FossilCell",
            for: indexPath
        ) as? FossilCollectionViewCell else { return UICollectionViewCell() }
        let fossil = fossilViewModel.creatures[indexPath.row]
        let fossilCollectionViewCellViewModel = FossilCollectionViewCellViewModel(fossilData: fossil)
        fossils.configureCell(with: fossilCollectionViewCellViewModel, view: self)
        return fossils
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = FossilDetailsViewController()
        let selectedFossil = fossilViewModel.creatures[indexPath.row]
        let fossilDetailsViewModel = FossilDetailsViewModel(fossilData: selectedFossil)
        detailsViewController.fossilDetailsViewModel = fossilDetailsViewModel
        detailsViewController.reloadDataDelegate = self
        self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
    }
}
