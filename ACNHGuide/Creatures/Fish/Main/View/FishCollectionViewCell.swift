//
//  FishCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit
import Combine

final class FishCollectionViewCell: UICollectionViewCell {
    
    private var viewModel: FishCollectionViewCellViewModel?
    private var cancellables = Set<AnyCancellable>()
    
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
        imageView.makeShadow()
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
        self.setUpContentView(color: "ColorBlueRoyal")
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: FishCollectionViewCellViewModel, view: ErrorToastable) {
        self.viewModel = viewModel
        fishFilenameLabel.text = viewModel.fileName
        if let url = viewModel.iconURL {
            fishImageView.loadImage(url: url)
                .sink { [weak self] image in
                    guard let self else { return }
                    fishImageView.image = image
                }
                .store(in: &cancellables)
        }
        let isSaved = viewModel.isFishAlreadySaved
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
        
        self.viewModel?.errorCreatureDatabase = { error in
            view.showDatabaseError(with: error)
        }
    }
}

private extension FishCollectionViewCell {
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
            fishFilenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            fishFilenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            fishFilenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            fishFilenameLabel.heightAnchor.constraint(equalToConstant: 44),
            
            fishImageView.topAnchor.constraint(equalTo: fishFilenameLabel.bottomAnchor),
            fishImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fishImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: fishImageView.bottomAnchor),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.widthAnchor.constraint(equalToConstant: 44),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
