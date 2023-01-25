//
//  DetailsCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 12/01/2023.
//

import UIKit

final class DetailsCollectionViewCell: UICollectionViewCell {
    
    private(set) var imageValueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 13
        imageView.backgroundColor = UIColor(named: "ColorSandLight")
        return imageView
    }()
    
    private(set) var titleValueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "FinkHeavy", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FinkHeavy", size: 16)
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
    
    func configureFishCell(imageNamed: String, title: String, value: String) {
        imageValueImageView.image = UIImage(named: imageNamed)
        titleValueLabel.text = title
        titleValueLabel.textColor = UIColor(named: "ColorBlueOcean") 
        valueLabel.text = value
        valueLabel.textColor = UIColor(named: "ColorBlueRoyal")
    }
    
    func configureSeaCreatureCell(imageNamed: String, title: String, value: String) {
        imageValueImageView.image = UIImage(named: imageNamed)
        titleValueLabel.text = title
        titleValueLabel.textColor = UIColor(named: "ColorBlueMidnight")
        valueLabel.text = value
        valueLabel.textColor = UIColor(named: "ColorBlueNight")
    }
    
    func configureBugCell(imageNamed: String, title: String, value: String) {
        imageValueImageView.image = UIImage(named: imageNamed)
        titleValueLabel.text = title
        titleValueLabel.textColor = UIColor(named: "ColorGreenDark")
        valueLabel.text = value
        valueLabel.textColor = UIColor(named: "ColorGreenGrass")
    }
    
    func configureFosssilCell(fossil: FossilData) {
        
    }
}

private extension DetailsCollectionViewCell {
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
