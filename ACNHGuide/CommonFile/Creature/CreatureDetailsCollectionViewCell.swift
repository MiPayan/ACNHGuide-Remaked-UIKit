//
//  DetailsCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 12/01/2023.
//

import UIKit

final class CreatureDetailsCollectionViewCell: UICollectionViewCell {
    
    private let imageValueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 13
        imageView.backgroundColor = UIColor(named: "ColorSandLight")
        return imageView
    }()
    
    private let titleValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(
        imageNamed: String,
        title: String,
        titleColorNamed: String,
        value: String,
        valueColorNamed: String
    ) {
        imageValueImageView.image = UIImage(named: imageNamed)
        titleValueLabel.text = title
        titleValueLabel.textColor = UIColor(named: titleColorNamed)
        valueLabel.text = value
        valueLabel.textColor = UIColor(named: valueColorNamed)
    }
}

private extension CreatureDetailsCollectionViewCell {
    func addSubviews() {
        addSubview(imageValueImageView)
        addSubview(titleValueLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            imageValueImageView.topAnchor.constraint(equalTo: topAnchor),
            imageValueImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageValueImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageValueImageView.widthAnchor.constraint(equalTo: imageValueImageView.heightAnchor),
            
            titleValueLabel.leadingAnchor.constraint(equalTo: imageValueImageView.trailingAnchor, constant: 8),
            titleValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleValueLabel.bottomAnchor.constraint(equalTo: imageValueImageView.centerYAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: titleValueLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: imageValueImageView.trailingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
