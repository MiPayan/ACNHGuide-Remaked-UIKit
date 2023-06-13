//
//  FishViewController.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class FishViewController: UIViewController {
    
    private let fishViewModel = FishViewModel()
    private let disposeBag = DisposeBag()
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
        collectionView.dataSource = nil
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var errorView: UIView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpCollectionViewBackground()
        bindViewModel()
        fishViewModel.getFishesData()
    }
}

private extension FishViewController {
    func bindViewModel() {
        fishViewModel.onError
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                errorView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        fishViewModel.fishesData
            .observe(on: MainScheduler.instance)
            .bind(to: fishCollectionView.rx.items(cellIdentifier: "FishCell", cellType: FishCollectionViewCell.self)) { row, fishData, fishCell in
                let fishCollectionViewCellViewModel = FishCollectionViewCellViewModel(fishData: fishData)
                fishCell.configureCell(with: fishCollectionViewCellViewModel, view: self)
            }
            .disposed(by: disposeBag)
        
        fishCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self else { return }
                let detailsViewController = FishDetailsViewController()
                let selectedFishObservable = self.fishViewModel.makeFish(with: indexPath.section, index: indexPath.row)
                selectedFishObservable.subscribe(onNext: { selectedFish in
                    let fishDetailsViewModel = FishDetailsViewModel(fishData: selectedFish)
                    detailsViewController.fishDetailsViewModel = fishDetailsViewModel
                    detailsViewController.reloadDataDelegate = self
                    self.navigationController?.showDetailViewController(detailsViewController, sender: nil)
                })
                .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
    
    func setUpCollectionViewBackground() {
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

extension Reactive where Base: UICollectionView {
    func numberOfItemsInSection() -> Binder<(section: Int, count: Int)> {
        return Binder(self.base) { collectionView, data in
            let section = data.section
            let count = data.count
            collectionView.performBatchUpdates(nil, completion: nil)
        }
    }
}
