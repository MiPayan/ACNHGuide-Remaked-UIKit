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
        collectionView.register(FossilCollectionViewCell.self, forCellWithReuseIdentifier: "FossilCell")
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
        fossilViewModel.getFossilData()
    }
}

private extension FossilViewController {
    func setUpUpdateDataHandler() {
        fossilViewModel.failureHandler = {
            self.errorView.isHidden = false
        }
        
        fossilViewModel.successHandler = {
            self.errorView.isHidden = true
            self.fossilCollectionView.reloadData()
        }
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

extension FossilViewController: ErrorViewDelegate {
    func didTapRefreshButton() {
        fossilViewModel.getFossilData()
    }
}

extension FossilViewController: UICollectionViewDataSource {
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
        headerView.headerLabel.text = "Fossils"
        return headerView
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: view.frame.width, height: 40.0)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fossilViewModel.fossilData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fossils = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FossilCell",
            for: indexPath
        ) as? FossilCollectionViewCell else { return UICollectionViewCell() }
        let fossil = fossilViewModel.fossilData[indexPath.row]
        fossils.configureCell(fossil: fossil)
        return fossils
    }
}


extension FossilViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedData = fossilViewModel.fossilData[indexPath.row]
        let detailsViewController = FossilDetailsViewController()
        detailsViewController.fossilData = selectedData
        self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
        print("Selected item at \(indexPath.row)")
    }
}

extension FossilViewController: UICollectionViewDelegateFlowLayout {
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
        return CGSize(width: widthPerItem - 8, height: 160)
    }
}
