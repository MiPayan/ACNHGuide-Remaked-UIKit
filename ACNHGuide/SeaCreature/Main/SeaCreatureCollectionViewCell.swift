//
//  SeaCreatureCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit

final class SeaCreatureCollectionViewCell: UICollectionViewCell {
    
    private var viewModel: SeaCreatureCollectionViewCellViewModel?
    private let seaCreatureFilenameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        return label
    }()
    
    private let seaCreatureImageView: UIImageView = {
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
        addSubviews()
        self.setUpContentView(color: "ColorBlueNightLite")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: SeaCreatureCollectionViewCellViewModel, view: ErrorToastable) {
        self.viewModel = viewModel
        seaCreatureFilenameLabel.text = viewModel.fileName
        if let url = viewModel.iconURL {
            seaCreatureImageView.loadImage(url: url)
        }
        let isSaved = viewModel.isSeaCreatureAlreadySaved
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
        
        self.viewModel?.errorCreatureDatabase = { error in
            view.showDatabaseError(with: error)
        }
    }
}

private extension SeaCreatureCollectionViewCell {    
    @objc func didTapSaveButton() {
        guard let viewModel else { return }
        let isSaved = viewModel.toggleSavedSeaCreature()
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
    
    func addSubviews() {
        addSubview(seaCreatureFilenameLabel)
        addSubview(seaCreatureImageView)
        addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            seaCreatureFilenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            seaCreatureFilenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            seaCreatureFilenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            seaCreatureImageView.topAnchor.constraint(equalTo: seaCreatureFilenameLabel.bottomAnchor, constant: 4),
            seaCreatureImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            seaCreatureImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            saveButton.topAnchor.constraint(equalTo: seaCreatureImageView.bottomAnchor, constant: 4),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
