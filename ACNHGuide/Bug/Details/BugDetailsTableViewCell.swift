//
//  BugDetailsTableViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 13/01/2023.
//

import UIKit

final class BugDetailsTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bugFilenameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ColorGreenGrass")
        label.font = UIFont(name: "FinkHeavy", size: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let bugImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let containerSaveButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "ColorGreenDark")
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
    
    private let bugCatchPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FinkHeavy", size: 16)
        label.textColor = UIColor(named: "ColorGreenDark")
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
        label.textColor = UIColor(named: "ColorGreenGrass")
        label.font = UIFont(name: "FinkHeavy", size: 22)
        label.text = "Museum phrase"
        return label
    }()
    
    private let bugMuseumPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "FinkHeavy", size: 16)
        label.textColor = UIColor(named: "ColorGreenDark")
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
    
    func configureDetailsCell(bugData: BugData) {
        guard let urlString = URL(string: bugData.iconURI) else { return }
        bugImageView.loadImage(url: urlString)
        bugFilenameLabel.text = bugData.fileName.replaceCharacter("_", by: " ").capitalized
        bugCatchPhraseLabel.text =  "\" \(bugData.catchPhrase) \""
        bugMuseumPhraseLabel.text = bugData.museumPhrase
    }
}

private extension BugDetailsTableViewCell {
    @objc func didTapSaveButton() {
        
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(bugFilenameLabel)
        containerView.addSubview(bugImageView)
        containerView.addSubview(containerSaveButtonView)
        containerSaveButtonView.addSubview(saveButton)
        containerView.addSubview(bugCatchPhraseLabel)
        addSubview(detailsCollectionView)
        addSubview(museumTitleLabel)
        addSubview(bugMuseumPhraseLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            
            bugFilenameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            bugFilenameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            bugFilenameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            bugFilenameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            bugImageView.topAnchor.constraint(equalTo: bugFilenameLabel.bottomAnchor, constant: 8),
            bugImageView.widthAnchor.constraint(equalTo: bugImageView.heightAnchor),
            bugImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            bugImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            containerSaveButtonView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containerSaveButtonView.bottomAnchor.constraint(equalTo: bugImageView.bottomAnchor, constant: -8),
            
            saveButton.topAnchor.constraint(equalTo: containerSaveButtonView.topAnchor, constant: 8),
            saveButton.leadingAnchor.constraint(equalTo: containerSaveButtonView.leadingAnchor, constant: 8),
            saveButton.trailingAnchor.constraint(equalTo: containerSaveButtonView.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: containerSaveButtonView.bottomAnchor, constant: -8),
            
            bugCatchPhraseLabel.topAnchor.constraint(equalTo: bugImageView.bottomAnchor, constant: 8),
            bugCatchPhraseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bugCatchPhraseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bugCatchPhraseLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            detailsCollectionView.topAnchor.constraint(equalTo: bugCatchPhraseLabel.bottomAnchor, constant: 16),
            detailsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsCollectionView.heightAnchor.constraint(equalToConstant: 218),
            
            museumTitleLabel.topAnchor.constraint(equalTo: detailsCollectionView.bottomAnchor, constant: 16),
            museumTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            museumTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            bugMuseumPhraseLabel.topAnchor.constraint(equalTo: museumTitleLabel.bottomAnchor, constant: 16),
            bugMuseumPhraseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bugMuseumPhraseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bugMuseumPhraseLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

extension BugDetailsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let detailsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "AdaptiveDetailsCell",
            for: indexPath
        ) as? DetailsCollectionViewCell else { return UICollectionViewCell() }
        let imageNamed = ["Bells", "Grass", "Timer", "Rarity", "North", "South"][indexPath.row]
        let title = ["Price", "Location", "Time", "Rarity", "Northern hemisphere", "Southern hemisphere"][indexPath.row]
        //        let value = [String(seaCreature.price), seaCreature.shadow, seaCreature.availability.time, seaCreature.speed, seaCreature.availability.monthNorthern, seaCreature.availability.monthSouthern][indexPath.row]
        
        detailsCell.configureBugCell(imageNamed: imageNamed, title: title, value: "600")
        return detailsCell
    }
}


extension BugDetailsTableViewCell: UICollectionViewDelegateFlowLayout {
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
