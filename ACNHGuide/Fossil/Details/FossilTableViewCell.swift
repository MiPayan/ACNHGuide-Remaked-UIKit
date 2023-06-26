//
//  FossilTableViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 25/01/2023.
//

import UIKit
import Combine

final class FossilTableViewCell: UITableViewCell {
    
    private var viewModel: FossilDetailsTableViewCellViewModel? {
        didSet {
            detailsCollectionView.reloadData()
        }
    }
    private var cancellables = Set<AnyCancellable>()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fossilFilenameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .brown
        label.font = UIFont(name: "FinkHeavy", size: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let fossilImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeShadow()
        return imageView
    }()
    
    private let containerSaveButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "ColorBrownHeart")
        view.layer.cornerRadius = 5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "leaf"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var detailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "AdaptiveDetailsCell")
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = false
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let museumTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .brown
        label.font = UIFont(name: "FinkHeavy", size: 22)
        label.text = "museum_phrase_title".localized
        return label
    }()
    
    private let fossilMuseumPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "FinkHeavy", size: 16)
        label.textColor = UIColor(named: "ColorBrownHeart")
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "ColorSand")
        contentView.isUserInteractionEnabled = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDetailsCell(with viewModel: FossilDetailsTableViewCellViewModel, view: ErrorToastable) {
        self.viewModel = viewModel
        if let url = viewModel.imageURL {
            fossilImageView.loadImage(url: url)
                .sink { [weak self] image in
                    guard let self else { return }
                    fossilImageView.image = image
                }
                .store(in: &cancellables)
        }
        fossilFilenameLabel.text = viewModel.fileName
        fossilMuseumPhraseLabel.text = viewModel.museumPhrase
        
        let isSaved = viewModel.isFossilAlreadySaved
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
        
        self.viewModel?.errorCreatureDatabase = { error in
            view.showDatabaseError(with: error)
        }
    }
}

private extension FossilTableViewCell {
    @objc func didTapSaveButton() {
        guard let viewModel else { return }
        let isSaved = viewModel.toggleSavedFossil()
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(fossilFilenameLabel)
        containerView.addSubview(fossilImageView)
        containerView.addSubview(containerSaveButtonView)
        containerSaveButtonView.addSubview(saveButton)
        addSubview(detailsCollectionView)
        addSubview(museumTitleLabel)
        addSubview(fossilMuseumPhraseLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            
            fossilFilenameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            fossilFilenameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            fossilFilenameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            fossilFilenameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            fossilImageView.topAnchor.constraint(equalTo: fossilFilenameLabel.bottomAnchor, constant: 8),
            fossilImageView.widthAnchor.constraint(equalTo: fossilImageView.heightAnchor),
            fossilImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            fossilImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            containerSaveButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containerSaveButtonView.bottomAnchor.constraint(equalTo: fossilImageView.bottomAnchor, constant: -8),
            
            saveButton.topAnchor.constraint(equalTo: containerSaveButtonView.topAnchor, constant: 8),
            saveButton.leadingAnchor.constraint(equalTo: containerSaveButtonView.leadingAnchor, constant: 8),
            saveButton.trailingAnchor.constraint(equalTo: containerSaveButtonView.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: containerSaveButtonView.bottomAnchor, constant: -8),
            
            detailsCollectionView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            detailsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsCollectionView.heightAnchor.constraint(equalToConstant: 76),
            
            museumTitleLabel.topAnchor.constraint(equalTo: detailsCollectionView.bottomAnchor, constant: 16),
            museumTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            museumTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            fossilMuseumPhraseLabel.topAnchor.constraint(equalTo: museumTitleLabel.bottomAnchor, constant: 16),
            fossilMuseumPhraseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fossilMuseumPhraseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fossilMuseumPhraseLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - CollectionViewDataSource

extension FossilTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel,
              let detailsCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "AdaptiveDetailsCell",
                for: indexPath
              ) as? DetailsCollectionViewCell else { return UICollectionViewCell() }
        detailsCell.configureCell(
            imageNamed: "Bells",
            title: "price".localized,
            titleColorNamed: "ColorBrownHeart",
            value: viewModel.price,
            valueColorNamed: "ColorBrownHeart"
        )
        return detailsCell
    }
}
