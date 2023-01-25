//
//  FishDetailsTableViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 13/01/2023.
//

import UIKit

final class FishDetailsTableViewCell: UITableViewCell {
    
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
        label.textColor = UIColor(named: "ColorBlueOcean")
        label.font = UIFont(name: "FinkHeavy", size: 22)
        label.text = "Museum phrase"
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
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDetailsCell(fishData: FishData) {
        guard let urlString = URL(string: fishData.iconURI) else { return }
        fishImageView.loadImage(url: urlString)
        fishFilenameLabel.text = fishData.fileName.replaceCharacter("_", by: " ").capitalized
        fishCatchPhraseLabel.text =  "\" \(fishData.catchPhrase) \""
        fishMuseumPhraseLabel.text = fishData.museumPhrase
    }
}

private extension FishDetailsTableViewCell {
    @objc func didTapSaveButton() {
//        TODO: - Save action
    }
    
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
            detailsCollectionView.heightAnchor.constraint(equalToConstant: 218),
            
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

extension FishDetailsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "AdaptiveDetailsCell",
            for: indexPath
        ) as? DetailsCollectionViewCell else { return UICollectionViewCell() }
        let imageNamed = ["Bells", "FishingRod", "FishShadow", "Timer", "Speedmeter", "North", "South"][indexPath.row]
        let title = ["Price", "Location", "Shadow", "Time", "Speed", "Northern hemisphere", "Southern hemisphere"][indexPath.row]
        //        let value = [String(seaCreature.price), seaCreature.shadow, seaCreature.availability.time, seaCreature.speed, seaCreature.availability.monthNorthern, seaCreature.availability.monthSouthern][indexPath.row]
        
        detailsCell.configureFishCell(imageNamed: imageNamed, title: title, value: "600")
        return detailsCell
    }
}


extension FishDetailsTableViewCell: UICollectionViewDelegateFlowLayout {
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
