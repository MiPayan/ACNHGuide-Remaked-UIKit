//
//  FossilTableViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 25/01/2023.
//

import UIKit

final class FossilTableViewCell: UITableViewCell {
    
    private var fossilDetailsViewModel: FossilDetailsViewModel? {
        didSet {
            detailsCollectionView.reloadData()
        }
    }
    
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
        label.text = "museum_phrase_title"
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
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDetailsCell(fossilDetailsViewModel: FossilDetailsViewModel) {
        self.fossilDetailsViewModel = fossilDetailsViewModel
        if let url = fossilDetailsViewModel.imageURL {
            fossilImageView.loadImage(url: url)
        }
        fossilFilenameLabel.text = fossilDetailsViewModel.filename
        fossilMuseumPhraseLabel.text = fossilDetailsViewModel.museumPhrase
    }
}

private extension FossilTableViewCell {
    @objc func didTapSaveButton() {
        
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

extension FossilTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let fossilDetailsViewModel,
              let detailsCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "AdaptiveDetailsCell",
                for: indexPath
              ) as? DetailsCollectionViewCell else { return UICollectionViewCell() }
        detailsCell.configureCell(
            imageNamed: "Bells",
            title: "price".localized,
            titleColorNamed: "ColorBrownHeart",
            value: fossilDetailsViewModel.price,
            valueColorNamed: "ColorBrownHeart"
        )
        return detailsCell
    }
}

extension FossilTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8.0, left: 32.0, bottom: 8.0, right: 32.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 24, height: 60)
    }
}
