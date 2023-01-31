//
//  SeaCreatureViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit

final class SeaCreatureViewController: UIViewController {
    
    private let seaCreatureViewModel = SeaCreatureViewModel()
    private lazy var seaCreatureCollectionView: UICollectionView = {
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
        collectionView.register(SeaCreatureCollectionViewCell.self, forCellWithReuseIdentifier: "SeaCreaturesCell")
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
        seaCreatureViewModel.getSeaCreatureData()
    }
}

private extension SeaCreatureViewController {
    func setCollectionViewBackground() {
        guard let blueRoyal = UIColor(named: "ColorBlueRoyal")?.cgColor,
              let blueNight = UIColor(named: "ColorBlueNight")?.cgColor else { return }
        let colors = [blueRoyal, blueNight, UIColor.black.cgColor]
        view.setCollectionViewBackground(collectionView: seaCreatureCollectionView, colors: colors)
    }
    
    func setUpUpdateDataHandler() {
        seaCreatureViewModel.failureHandler = {
            self.errorView.isHidden = false
        }
        
        seaCreatureViewModel.successHandler = {
            self.errorView.isHidden = true
            self.seaCreatureCollectionView.reloadData()
        }
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

extension SeaCreatureViewController: ErrorViewDelegate {
    func didTapRefreshButton() {
        seaCreatureViewModel.getSeaCreatureData()
    }
}

extension SeaCreatureViewController: UICollectionViewDataSource {
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
        if indexPath.section == 0 {
            headerView.headerLabel.text = "Northern Hemisphere"
            
            return headerView
        }
        headerView.headerLabel.text = "All sea creatures"
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return seaCreatureViewModel.makeSeaCreaturesFromTheNorthernHemisphere().count
        }
        return seaCreatureViewModel.makeSeaCreaturesFromTheSouthernHemisphere().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0,
           let northernSeaCreatures = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SeaCreaturesCell",
            for: indexPath
           ) as? SeaCreatureCollectionViewCell {
            let seaCreature = seaCreatureViewModel.makeSeaCreaturesFromTheNorthernHemisphere()[indexPath.row]
            northernSeaCreatures.configureCell(seaCreature: seaCreature)
            return northernSeaCreatures
        }
        
        guard let southernSeaCreatures = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SeaCreaturesCell",
            for: indexPath
        ) as? SeaCreatureCollectionViewCell else { return UICollectionViewCell() }
        let seaCreature = seaCreatureViewModel.makeSeaCreaturesFromTheSouthernHemisphere()[indexPath.row]
        southernSeaCreatures.configureCell(seaCreature: seaCreature)
        return southernSeaCreatures
    }
}


extension SeaCreatureViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = SeaCreatureDetailsViewController()
        if indexPath.section == 0 {
            let selectedNorthernData = seaCreatureViewModel.makeSeaCreaturesFromTheNorthernHemisphere()[indexPath.row]
            detailsViewController.seaCreatureData = selectedNorthernData
        } else {
            let selectedSouthernData = seaCreatureViewModel.makeSeaCreaturesFromTheSouthernHemisphere()[indexPath.row]
            detailsViewController.seaCreatureData = selectedSouthernData
        }
        self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
    }
}

extension SeaCreatureViewController: UICollectionViewDelegateFlowLayout {
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
