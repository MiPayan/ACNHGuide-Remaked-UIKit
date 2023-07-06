//
//  BugCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit
import Combine

final class BugCollectionViewCell: UICollectionViewCell {
    
    private var viewModel: BugCollectionViewCellViewModel?
    private var cancellables = Set<AnyCancellable>()
    private let bugFilenameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bugImageView: UIImageView = {
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
        self.setUpContentView(color: "ColorGreenDark")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with viewModel: BugCollectionViewCellViewModel, view: ErrorToastable) {
        self.viewModel = viewModel
        bugFilenameLabel.text = viewModel.fileName
        if let url = viewModel.iconURL {
            bugImageView.loadImage(url: url)
                .sink { [weak self] image in
                    guard let self else { return }
                    bugImageView.image = image
                }
                .store(in: &cancellables)
        }
        let isSaved = viewModel.isBugAlreadySaved
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
        
        self.viewModel?.errorCreatureDatabase = { error in
            view.showDatabaseError(with: error)
        }
    }
}

private extension BugCollectionViewCell {    
    @objc func didTapSaveButton() {
        guard let viewModel else { return }
        let isSaved = viewModel.toggleSavedBug()
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
    
    func addSubviews() {
        addSubview(bugFilenameLabel)
        addSubview(bugImageView)
        addSubview(saveButton)
        NSLayoutConstraint.activate([
            bugFilenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            bugFilenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bugFilenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            bugImageView.topAnchor.constraint(equalTo: bugFilenameLabel.bottomAnchor, constant: 4),
            bugImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bugImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            saveButton.topAnchor.constraint(equalTo: bugImageView.bottomAnchor, constant: 4),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
