//
//  SeaCreatureCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 06/01/2023.
//

import UIKit

final class SeaCreatureCollectionViewCell: UICollectionViewCell {
    
    private(set) var seaCreatureFilenameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var seaCreatureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) var seaCreaturePriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addConstraints()
        setContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(seaCreature: SeaCreatureData) {
        guard let urlString = URL(string: seaCreature.iconURI) else { return }
        seaCreatureFilenameLabel.text = seaCreature.fileName.replaceCharacter("_", by: " ").capitalized
        seaCreatureImageView.loadImage(url: urlString)
        seaCreaturePriceLabel.text = String(seaCreature.price)
    }
}

private extension SeaCreatureCollectionViewCell {
    func setContentView() {
        self.backgroundColor = UIColor(named: "ColorBlueNightLite")
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func addSubviews() {
        addSubview(seaCreatureFilenameLabel)
        addSubview(seaCreatureImageView)
        addSubview(seaCreaturePriceLabel)
    }
    
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            seaCreatureFilenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            seaCreatureFilenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            seaCreatureFilenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            seaCreatureImageView.topAnchor.constraint(equalTo: seaCreatureFilenameLabel.bottomAnchor, constant: 8),
            seaCreatureImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            seaCreatureImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            seaCreaturePriceLabel.topAnchor.constraint(equalTo: seaCreatureImageView.bottomAnchor, constant: 8),
            seaCreaturePriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            seaCreaturePriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            seaCreaturePriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
