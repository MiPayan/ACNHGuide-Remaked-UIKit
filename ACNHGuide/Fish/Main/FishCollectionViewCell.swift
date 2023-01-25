//
//  FishCollectionViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit

final class FishCollectionViewCell: UICollectionViewCell {
    
    private(set) var fishFilenameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 15)
        return label
    }()
    
    private(set) var fishImageView: UIImageView = {
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
        button.addTarget(self, action: #selector(isTapped), for: .touchUpInside)
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
    
    func configureCell(fish: FishData) {
        guard let urlString = URL(string: fish.iconURI) else { return }
        fishFilenameLabel.text = fish.fileName.replaceCharacter("_", by: " ").capitalized
        fishImageView.loadImage(url: urlString)
    }
    
    @objc func isTapped() {
        isSaved.toggle()
        let imageString = isSaved ? "leaf.fill" : "leaf"
        saveButton.setImage(UIImage(systemName: imageString), for: .normal)
    }
}

private extension FishCollectionViewCell {
    func setContentView() {
        self.backgroundColor = UIColor(named: "ColorBlueRoyal")
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func addSubviews() {
        addSubview(fishFilenameLabel)
        addSubview(fishImageView)
        addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            fishFilenameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            fishFilenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            fishFilenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            fishImageView.topAnchor.constraint(equalTo: fishFilenameLabel.bottomAnchor),
            fishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            fishImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            fishImageView.bottomAnchor.constraint(equalTo: saveButton.topAnchor),
            
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
