//
//  BugCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class BugCollectionViewCell: UICollectionViewCell {
    private(set) var bugFilenameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var bugImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) var bugPriceLabel: UILabel = {
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
    
    func configureCell(bug: BugData) {
        guard let urlString = URL(string: bug.iconURI) else { return }
        bugFilenameLabel.text = bug.fileName.replaceCharacter("_", by: " ").capitalized
        bugImageView.loadImage(url: urlString)
        bugPriceLabel.text = String(bug.price)
    }
}

private extension BugCollectionViewCell {
    func setContentView() {
        self.backgroundColor = UIColor(named: "ColorGreenDark")
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func addSubviews() {
        addSubview(bugFilenameLabel)
        addSubview(bugImageView)
        addSubview(bugPriceLabel)
    }
    
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            bugFilenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            bugFilenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bugFilenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            bugImageView.topAnchor.constraint(equalTo: bugFilenameLabel.bottomAnchor, constant: 8),
            bugImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bugImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            bugPriceLabel.topAnchor.constraint(equalTo: bugImageView.bottomAnchor, constant: 8),
            bugPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            bugPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bugPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}

