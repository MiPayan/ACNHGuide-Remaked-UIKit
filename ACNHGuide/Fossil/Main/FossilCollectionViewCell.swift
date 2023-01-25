//
//  FossilCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class FossilCollectionViewCell: UICollectionViewCell {
    
    private(set) var fossilFilenameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var fossilImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) var fossilPriceLabel: UILabel = {
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
    
    func configureCell(fossil: FossilData) {
        guard let urlString = URL(string: fossil.imageURI) else { return }
        fossilFilenameLabel.text = fossil.fileName.replaceCharacter("_", by: " ").capitalized
        fossilImageView.loadImage(url: urlString)
        fossilPriceLabel.text = String(fossil.price)
    }
}

private extension FossilCollectionViewCell {
    func setContentView() {
        self.backgroundColor = UIColor(named: "ColorBrownHeart")
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func addSubviews() {
        addSubview(fossilFilenameLabel)
        addSubview(fossilImageView)
        addSubview(fossilPriceLabel)
    }
    
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            fossilFilenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            fossilFilenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            fossilFilenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            fossilImageView.topAnchor.constraint(equalTo: fossilFilenameLabel.bottomAnchor, constant: 8),
            fossilImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            fossilImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            fossilPriceLabel.topAnchor.constraint(equalTo: fossilImageView.bottomAnchor, constant: 8),
            fossilPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            fossilPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            fossilPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
