//
//  FishesCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 07/06/2023.
//

import UIKit

final class FishesCollectionViewCell: UICollectionViewCell {
    
    private var viewModel: FishesCollectionViewCellViewModel?
    private let fishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(named: "ColorBlueRoyal")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let fishFileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fishImageView.layer.cornerRadius = fishImageView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionViewCell(with viewModel: FishesCollectionViewCellViewModel) {
        self.viewModel = viewModel
        if let url = viewModel.iconURL {
            fishImageView.loadImage(url: url)
        }
        fishFileNameLabel.text = viewModel.fileName
    }
}

private extension FishesCollectionViewCell {
    func addSubviews() {
        addSubview(fishImageView)
        addSubview(fishFileNameLabel)
        NSLayoutConstraint.activate([
            fishImageView.topAnchor.constraint(equalTo: topAnchor),
            fishImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fishImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fishImageView.heightAnchor.constraint(equalToConstant: 100),
            
            fishFileNameLabel.topAnchor.constraint(equalTo: fishImageView.bottomAnchor, constant: 4),
            fishFileNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            fishFileNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            fishFileNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
