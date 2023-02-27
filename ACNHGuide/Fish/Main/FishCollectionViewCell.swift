//
//  FishCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class FishCollectionViewCell: UICollectionViewCell {
    
    private var viewModel: FishCollectionViewCellViewModel?
    private let fishFilenameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        return label
    }()
    
    private let fishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "leaf"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: FishCollectionViewCellViewModel) {
        self.viewModel = viewModel
        fishFilenameLabel.text = viewModel.fileName
        if let url = viewModel.iconURL {
            fishImageView.loadImage(url: url)
        }
        let isSaved = viewModel.isFishAlreadySaved
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
}

private extension FishCollectionViewCell {
    func setContentView() {
        self.backgroundColor = UIColor(named: "ColorBlueRoyal")
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    @objc func didTapSaveButton() {
        guard let viewModel else { return }
        let isSaved = viewModel.toggleSavedFish()
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
    
    func addSubviews() {
        addSubview(fishFilenameLabel)
        addSubview(fishImageView)
        addSubview(saveButton)
        NSLayoutConstraint.activate([
            fishFilenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            fishFilenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            fishFilenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            fishImageView.topAnchor.constraint(equalTo: fishFilenameLabel.bottomAnchor, constant: 4),
            fishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            fishImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            saveButton.topAnchor.constraint(equalTo: fishImageView.bottomAnchor, constant: 4),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
