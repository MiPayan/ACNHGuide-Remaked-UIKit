//
//  FishDetailsTableViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 13/01/2023.
//

import UIKit
import Combine

final class FishDetailsTableViewCell: UITableViewCell {
    
    private var viewModel: FishDetailsTableViewCellViewModel? {
        didSet {
            self.detailsCollectionView.reloadData()
        }
    }
    private var cancellables = Set<AnyCancellable>()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fishFilenameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ColorBlueOcean")
        label.font = UIFont(name: "FinkHeavy", size: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let fishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeShadow()
        return imageView
    }()
    
    private let containerSaveButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "ColorBlueRoyal")
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
    
    private let fishCatchPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FinkHeavy", size: 16)
        label.textColor = UIColor(named: "ColorBlueRoyal")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CreatureDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "AdaptiveDetailsCell")
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
        label.textColor = UIColor(named: "ColorBlueOcean")
        label.font = UIFont(name: "FinkHeavy", size: 22)
        label.text = "museum_phrase_title".localized
        return label
    }()
    
    private let fishMuseumPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "FinkHeavy", size: 16)
        label.textColor = UIColor(named: "ColorBlueRoyal")
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
    
    func configureDetailsCell(with viewModel: FishDetailsTableViewCellViewModel, view: ErrorToastable) {
        self.viewModel = viewModel
        if let url = viewModel.iconURL {
            fishImageView.loadImage(url: url)
                .sink { [weak self] image in
                    guard let self else { return }
                    fishImageView.image = image
                }
                .store(in: &cancellables)
        }
        fishFilenameLabel.text = viewModel.fileName
        fishCatchPhraseLabel.text = viewModel.catchPhrase
        fishMuseumPhraseLabel.text = viewModel.museumPhrase
        
        let isSaved = viewModel.isFishAlreadySaved
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
        self.viewModel?.errorCreatureDatabase = { error in
            view.showDatabaseError(with: error)
        }
    }
    
    @objc func didTapSaveButton() {
        guard let viewModel else { return }
        let isSaved = viewModel.toggleSavedFish()
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
}

// MARK: - Layout constraints

private extension FishDetailsTableViewCell {
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(fishFilenameLabel)
        containerView.addSubview(fishImageView)
        containerView.addSubview(containerSaveButtonView)
        containerSaveButtonView.addSubview(saveButton)
        containerView.addSubview(fishCatchPhraseLabel)
        addSubview(detailsCollectionView)
        addSubview(museumTitleLabel)
        addSubview(fishMuseumPhraseLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            
            fishFilenameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            fishFilenameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            fishFilenameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            fishFilenameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            fishImageView.topAnchor.constraint(equalTo: fishFilenameLabel.bottomAnchor, constant: 8),
            fishImageView.widthAnchor.constraint(equalTo: fishImageView.heightAnchor),
            fishImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            fishImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            containerSaveButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containerSaveButtonView.bottomAnchor.constraint(equalTo: fishImageView.bottomAnchor, constant: -8),
            
            saveButton.topAnchor.constraint(equalTo: containerSaveButtonView.topAnchor, constant: 8),
            saveButton.leadingAnchor.constraint(equalTo: containerSaveButtonView.leadingAnchor, constant: 8),
            saveButton.trailingAnchor.constraint(equalTo: containerSaveButtonView.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: containerSaveButtonView.bottomAnchor, constant: -8),
            
            fishCatchPhraseLabel.topAnchor.constraint(equalTo: fishImageView.bottomAnchor, constant: 8),
            fishCatchPhraseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fishCatchPhraseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fishCatchPhraseLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            detailsCollectionView.topAnchor.constraint(equalTo: fishCatchPhraseLabel.bottomAnchor, constant: 16),
            detailsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsCollectionView.heightAnchor.constraint(equalToConstant: 278),
            
            museumTitleLabel.topAnchor.constraint(equalTo: detailsCollectionView.bottomAnchor, constant: 16),
            museumTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            museumTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            fishMuseumPhraseLabel.topAnchor.constraint(equalTo: museumTitleLabel.bottomAnchor, constant: 16),
            fishMuseumPhraseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fishMuseumPhraseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            fishMuseumPhraseLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - CollectionViewDataSource

extension FishDetailsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel else { return 0 }
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel,
              let detailsCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "AdaptiveDetailsCell",
                for: indexPath
              ) as? CreatureDetailsCollectionViewCell else { return UICollectionViewCell() }
        detailsCell.configureCell(
            imageNamed: viewModel.makeImageName(at: indexPath.row),
            title: viewModel.makeTitle(at: indexPath.row),
            titleColorNamed: "ColorBlueOcean",
            value: viewModel.makeValue(at: indexPath.row),
            valueColorNamed: "ColorBlueRoyal"
        )
        return detailsCell
    }
}
