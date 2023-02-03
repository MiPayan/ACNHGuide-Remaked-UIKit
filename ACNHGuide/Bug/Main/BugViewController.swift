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
            MainViewCollectionReusableView.self,
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
        didTapRefreshButton()
        bugViewModel.getBugData()
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

extension BugViewController: ErrorViewDelegate {
    func didTapRefreshButton() {
        bugViewModel.getBugData()
    }
}

extension BugViewController: UICollectionViewDataSource {
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
        headerView.headerLabel.text = bugViewModel.setHeaderSection(with: indexPath.section)
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
        bugViewModel.configureSectionCollectionView(with: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let bugCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "BugCell",
            for: indexPath
        ) as? BugCollectionViewCell else { return UICollectionViewCell() }
        let bug = bugViewModel.configureCollectionView(with: indexPath.section, index: indexPath.row)
        bugCell.configureCell(bug: bug)
        return bugCell
    }
}

extension BugViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = BugDetailsViewController()
        let selectedBug = bugViewModel.configureCollectionView(with: indexPath.section, index: indexPath.row)
        detailsViewController.bugData = selectedBug
        self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
    }
}

extension BugViewController: UICollectionViewDelegateFlowLayout {
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
