//
//  DashboardTableViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 25/01/2023.
//

import UIKit

final class DashboardTableViewCell: UITableViewCell {
    
    private let objectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let objectTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FinkHeavy", size: 20)
        label.textColor = .white
        return label
    }()
    
    private var itemSavedCount = 40
    private let objectProgressView: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.trackTintColor = .white
        progressBar.progress = 0.5
        return progressBar
    }()
    
    private let objectTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureFishCell(fishData: [FishData]) {
        backgroundColor = UIColor(named: "ColorBlueRoyal")
        guard let urlString = fishData.first?.iconURI,
              let url = URL(string: urlString) else { return }
        objectTitleLabel.text = "Fishes"
        objectImageView.loadImage(url: url)
        objectProgressView.progressTintColor = UIColor(named: "ColorBlueOcean")
        objectProgressView.progress = Float(itemSavedCount) / Float(fishData.count)
        objectTotalLabel.text = "\(itemSavedCount)/\(fishData.count)"
    }
    
    func configureSeaCreatureCell(seaCreatureData: [SeaCreatureData]) {
        backgroundColor = UIColor(named: "ColorBlueNightLite")
        guard let urlString = seaCreatureData.first?.iconURI,
              let url = URL(string: urlString) else { return }
        objectTitleLabel.text = "Sea creatures"
        objectImageView.loadImage(url: url)
        objectProgressView.progressTintColor = UIColor(named: "ColorBlueRoyal")
        objectProgressView.progress = Float(itemSavedCount) / Float(seaCreatureData.count)
        objectTotalLabel.text = "\(itemSavedCount)/\(seaCreatureData.count)"
    }
    
    func configureBugCell(bugData: [BugData]) {
        backgroundColor = UIColor(named: "ColorGreenDark")
        guard let urlString = bugData.first?.iconURI,
              let url = URL(string: urlString) else { return }
        objectTitleLabel.text = "Bugs"
        objectImageView.loadImage(url: url)
        objectProgressView.progressTintColor = UIColor(named: "ColorGreenGrass")
        objectProgressView.progress = Float(itemSavedCount) / Float(bugData.count)
        objectTotalLabel.text = "\(itemSavedCount)/\(bugData.count)"
    }
    
    func configureFossilCell(fossilData: [FossilData]) {
        backgroundColor = UIColor(named: "ColorBrownHeart")
        guard let urlString = fossilData.first?.imageURI,
              let url = URL(string: urlString) else { return }
        objectTitleLabel.text = "Fossils"
        objectImageView.loadImage(url: url)
        objectProgressView.progressTintColor = .brown
        objectProgressView.progress = Float(itemSavedCount) / Float(fossilData.count)
        objectTotalLabel.text = "\(itemSavedCount)/\(fossilData.count)"
    }
    
    func addSubviews() {
        addSubview(objectImageView)
        addSubview(objectTitleLabel)
        addSubview(objectProgressView)
        addSubview(objectTotalLabel)
        NSLayoutConstraint.activate([
            objectImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            objectImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            objectImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            objectImageView.widthAnchor.constraint(equalToConstant: 80),
            objectImageView.heightAnchor.constraint(equalToConstant: 80),
            
            objectTitleLabel.leadingAnchor.constraint(equalTo: objectImageView.trailingAnchor, constant: 16),
            objectTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            objectTotalLabel.topAnchor.constraint(equalTo: objectImageView.centerYAnchor),
            
            objectProgressView.topAnchor.constraint(equalTo: objectTitleLabel.bottomAnchor, constant: 8),
            objectProgressView.leadingAnchor.constraint(equalTo: objectImageView.trailingAnchor, constant: 16),
            objectProgressView.heightAnchor.constraint(equalToConstant: 2),
            
            objectTotalLabel.leadingAnchor.constraint(equalTo: objectProgressView.trailingAnchor, constant: 8),
            objectTotalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            objectTotalLabel.centerYAnchor.constraint(equalTo: objectProgressView.centerYAnchor),
        ])
    }
}
