//
//  DetailsTableViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit
import Combine

final class SeaCreatureDetailsTableViewCell: UITableViewCell {
    
    private var viewModel: SeaCreaturesDetailsTableViewCellViewModel? {
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
    
    private let seaCreatureFilenameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ColorBlueMidnight")
        label.font = UIFont(name: "FinkHeavy", size: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let seaCreatureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.makeShadow()
        return imageView
    }()
    
    private let containerSaveButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "ColorBlueNightLite")
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
    
    private let seaCreatureCatchPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ColorBlueNight")
        label.font = UIFont(name: "FinkHeavy", size: 16)
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
        label.textColor = UIColor(named: "ColorBlueMidnight")
        label.font = UIFont(name: "FinkHeavy", size: 22)
        label.text = "museum_phrase_title".localized
        return label
    }()
    
    private let seaCreatureMuseumPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ColorBlueNight")
        label.font = UIFont(name: "FinkHeavy", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
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
    
    func configureDetailsCell(with viewModel: SeaCreaturesDetailsTableViewCellViewModel, view: ErrorToastable) {
        self.viewModel = viewModel
        if let url = viewModel.iconURL {
            seaCreatureImageView.loadImage(url: url)
                .sink { [weak self] image in
                    guard let self else { return }
                    seaCreatureImageView.image = image
                }
                .store(in: &cancellables)
        }
        seaCreatureFilenameLabel.text = viewModel.fileName
        seaCreatureCatchPhraseLabel.text = viewModel.catchPhrase
        seaCreatureMuseumPhraseLabel.text = viewModel.museumPhrase
        
        let isSaved = viewModel.isSeaCreatureAlreadySaved
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
        
        self.viewModel?.errorCreatureDatabase = { error in
            view.showDatabaseError(with: error)
        }
    }
}

private extension SeaCreatureDetailsTableViewCell {
    @objc func didTapSaveButton() {
        guard let viewModel else { return }
        let isSaved = viewModel.toggleSavedSeaCreature()
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(seaCreatureFilenameLabel)
        containerView.addSubview(seaCreatureImageView)
        containerView.addSubview(containerSaveButtonView)
        containerSaveButtonView.addSubview(saveButton)
        containerView.addSubview(seaCreatureCatchPhraseLabel)
        addSubview(detailsCollectionView)
        addSubview(museumTitleLabel)
        addSubview(seaCreatureMuseumPhraseLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            
            seaCreatureFilenameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            seaCreatureFilenameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            seaCreatureFilenameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            seaCreatureFilenameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            seaCreatureImageView.topAnchor.constraint(equalTo: seaCreatureFilenameLabel.bottomAnchor, constant: 8),
            seaCreatureImageView.widthAnchor.constraint(equalTo: seaCreatureImageView.heightAnchor),
            seaCreatureImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            seaCreatureImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            containerSaveButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containerSaveButtonView.bottomAnchor.constraint(equalTo: seaCreatureImageView.bottomAnchor, constant: -8),
            
            saveButton.topAnchor.constraint(equalTo: containerSaveButtonView.topAnchor, constant: 8),
            saveButton.leadingAnchor.constraint(equalTo: containerSaveButtonView.leadingAnchor, constant: 8),
            saveButton.trailingAnchor.constraint(equalTo: containerSaveButtonView.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: containerSaveButtonView.bottomAnchor, constant: -8),
            
            seaCreatureCatchPhraseLabel.topAnchor.constraint(equalTo: seaCreatureImageView.bottomAnchor, constant: 8),
            seaCreatureCatchPhraseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            seaCreatureCatchPhraseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            seaCreatureCatchPhraseLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            detailsCollectionView.topAnchor.constraint(equalTo: seaCreatureCatchPhraseLabel.bottomAnchor, constant: 16),
            detailsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsCollectionView.heightAnchor.constraint(equalToConstant: 218),
            
            museumTitleLabel.topAnchor.constraint(equalTo: detailsCollectionView.bottomAnchor, constant: 16),
            museumTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            museumTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            seaCreatureMuseumPhraseLabel.topAnchor.constraint(equalTo: museumTitleLabel.bottomAnchor, constant: 16),
            seaCreatureMuseumPhraseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            seaCreatureMuseumPhraseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            seaCreatureMuseumPhraseLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

// - MARK: - CollectionViewDataSource

extension SeaCreatureDetailsTableViewCell: UICollectionViewDataSource {
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
            titleColorNamed: "ColorBlueMidnight",
            value: viewModel.makeValue(at: indexPath.row),
            valueColorNamed: "ColorBlueNight"
        )
        return detailsCell
    }
}
