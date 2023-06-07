//
//  FishesTableViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 07/06/2023.
//

import UIKit

final class FishesTableViewCell: UITableViewCell {
    
    private var viewModel: FishesTableViewCellViewModel? {
        didSet {
            self.fishesCollectionView.reloadData()
        }
    }
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var fishesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FishesCollectionViewCell.self, forCellWithReuseIdentifier: "fishCell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.isUserInteractionEnabled = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: FishesTableViewCellViewModel) {
        self.viewModel = viewModel
    }
    
    func configureSubTitle(with subTitleText: String) {
        subTitleLabel.text = viewModel?.makeSubTitle(with: subTitleText)
    }
}

private extension FishesTableViewCell {
    func addSubviews() {
        addSubview(subTitleLabel)
        addSubview(fishesCollectionView)
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            fishesCollectionView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 8),
            fishesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fishesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fishesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            fishesCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}

extension FishesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "fishCell",
                for: indexPath
              ) as? FishesCollectionViewCell else { return UICollectionViewCell() }
        let fish = viewModel.makeFish(at: indexPath.row)
        let fishesCollectionViewCellViewModel = FishesCollectionViewCellViewModel(fishData: fish)
        cell.configureCollectionViewCell(with: fishesCollectionViewCellViewModel)
        return cell
    }
}
