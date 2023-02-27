//
//  FossilCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class FossilCollectionViewCell: UICollectionViewCell {
    
    private var viewModel: FossilCollectionViewCellViewModel?
    private let fossilFilenameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fossilImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    func configureCell(with viewModel: FossilCollectionViewCellViewModel) {
        self.viewModel = viewModel
        fossilFilenameLabel.text = viewModel.fileName
        if let url = viewModel.imageURL {
            fossilImageView.loadImage(url: url)
        }
        let isSaved = viewModel.isFossilAlreadySaved
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
}

private extension FossilCollectionViewCell {
    func setContentView() {
        self.backgroundColor = UIColor(named: "ColorBrownHeart")
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    @objc func didTapSaveButton() {
        guard let viewModel else { return }
        let isSaved = viewModel.toggleSavedFossil()
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
    
    func addSubviews() {
        addSubview(fossilFilenameLabel)
        addSubview(fossilImageView)
        addSubview(saveButton)
        NSLayoutConstraint.activate([
            fossilFilenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            fossilFilenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            fossilFilenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            fossilImageView.topAnchor.constraint(equalTo: fossilFilenameLabel.bottomAnchor, constant: 4),
            fossilImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            fossilImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            saveButton.topAnchor.constraint(equalTo: fossilImageView.bottomAnchor, constant: 4),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
