//
//  SeaCreatureCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit

final class SeaCreatureCollectionViewCell: UICollectionViewCell {
    
    private let seaCreatureFilenameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seaCreatureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var isSaved = false
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "leaf"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(isTappedTheSaveButton), for: .touchUpInside)
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
    
    func configureCell(seaCreature: SeaCreatureData) {
        guard let urlString = URL(string: seaCreature.iconURI) else { return }
        seaCreatureFilenameLabel.text = seaCreature.fileName.replaceCharacter("_", by: " ").capitalized
        seaCreatureImageView.loadImage(url: urlString)
    }
}

private extension SeaCreatureCollectionViewCell {
    func setContentView() {
        self.backgroundColor = UIColor(named: "ColorBlueNightLite")
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    @objc func isTappedTheSaveButton() {
        isSaved.toggle()
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
