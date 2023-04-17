//
//  BugViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit

final class BugViewController: UIViewController {
    
    private let bugViewModel = BugViewModel()
    private lazy var bugCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            CreatureCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "AdaptiveHeader"
        )
        collectionView.register(BugCollectionViewCell.self, forCellWithReuseIdentifier: "BugCell")
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
        bugViewModel.getBugsData()
    }
}

private extension BugViewController {
    func setUpUpdateDataHandler() {
        bugViewModel.failureHandler = {
            self.errorView.isHidden = false
        }
        
        bugViewModel.successHandler = {
            self.errorView.isHidden = true
            self.bugCollectionView.reloadData()
        }
    }
    
    func setCollectionViewBackground() {
        guard let greenGrass = UIColor(named: "ColorGreenGrass")?.cgColor,
              let greenDark = UIColor(named: "ColorGreenDark")?.cgColor else { return }
        let colors = [greenGrass, greenDark, UIColor.black.cgColor]
        view.setCollectionViewBackground(collectionView: bugCollectionView, colors: colors)
    }
    
    func addSubviews() {
        view.addSubview(bugCollectionView)
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            bugCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            bugCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bugCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bugCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - ReloadDataDelegate

extension BugViewController: ReloadDataDelegate {
    func reloadData() {
        bugCollectionView.reloadData()
    }
}

// MARK: - ErrorToastable

extension BugViewController: ErrorToastable {
    func showDatabaseError(with text: String) {
        self.showToast(with: text)
    }
}

// MARK: - CollectionViewDataSource

extension BugViewController: UICollectionViewDataSource {
    
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
        headerView.configureHeaderLabel(with: bugViewModel.setHeaderSection(with: indexPath.section))
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
        return bugViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bugViewModel.configureSectionCollectionView(with: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let bugCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "BugCell",
            for: indexPath
        ) as? BugCollectionViewCell else { return UICollectionViewCell() }
        let bug = bugViewModel.makeBug(with: indexPath.section, index: indexPath.row)
        let bugCollecitonViewCellViewModel = BugCollectionViewCellViewModel(bugData: bug)
        bugCell.configureCell(with: bugCollecitonViewCellViewModel, view: self)
        return bugCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = BugDetailsViewController()
        let selectedBug = bugViewModel.makeBug(with: indexPath.section, index: indexPath.row)
        let bugDetailsViewModel = BugDetailsViewModel(bugData: selectedBug)
        detailsViewController.bugDetailsViewModel = bugDetailsViewModel
        detailsViewController.reloadDataDelegate = self
        self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
    }
}
