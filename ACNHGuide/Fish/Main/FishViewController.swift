//
//  FishViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit
import RealmSwift

final class FishViewController: UIViewController {
    
    private let fishViewModel = FishViewModel()
    private lazy var fishCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            MainViewCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "AdaptiveHeader"
        )
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
        setCollectionViewBackground()
        setUpUpdateDataHandler()
        fishViewModel.getFishData()
    }
}

private extension FishViewController {
    func setUpUpdateDataHandler() {
        fishViewModel.failureHandler = {
            self.errorView.isHidden = false
        }
        
        fishViewModel.successHandler = {
            self.errorView.isHidden = true
            self.fishCollectionView.reloadData()
        }
    }
    
    func setCollectionViewBackground() {
        guard let blueOcean = UIColor(named: "ColorBlueOcean")?.cgColor,
              let blueRoyal = UIColor(named: "ColorBlueRoyal")?.cgColor else { return }
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

extension FishViewController: ReloadDataDelegate {
    func reloadCollectionView() {
        fishCollectionView.reloadData()
    }
}

extension FishViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "AdaptiveHeader",
            for: indexPath
        ) as? MainViewCollectionReusableView else { return UICollectionReusableView() }
        headerView.configureHeaderLabel(with: fishViewModel.setHeaderSection(with: indexPath.section))
        return headerView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: view.frame.width, height: 40.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fishViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fishViewModel.configureSectionCollectionView(with: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fishCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FishCell",
            for: indexPath
        ) as? FishCollectionViewCell else { return UICollectionViewCell() }
        let fish = fishViewModel.configureCollectionView(with: indexPath.section, index: indexPath.row)
        let fishCollectionViewCellViewModel = FishCollectionViewCellViewModel(fishData: fish)
        fishCell.configureCell(with: fishCollectionViewCellViewModel)
        return fishCell
    }
}

extension FishViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = FishDetailsViewController()
        let selectedFish = fishViewModel.configureCollectionView(with: indexPath.section, index: indexPath.row)
        let fishDetailsViewModel = FishDetailsViewModel(fishData: selectedFish)
        detailsViewController.fishDetailsViewModel = fishDetailsViewModel
        detailsViewController.reloadDataDelegate = self
        self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
    }
}

extension FishViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let widthPerItem = collectionView.frame.width / 3 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: 140)
    }
}
