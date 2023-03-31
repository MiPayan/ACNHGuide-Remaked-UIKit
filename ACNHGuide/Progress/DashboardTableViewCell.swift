//
//  DashboardTableViewCell.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 25/01/2023.
//

import UIKit

final class DashboardTableViewCell: UITableViewCell {
    
    private var fishDashboardTableViewCellViewModel: FishDashboardTableViewCellViewModel?
    private var seaCreatureDashboardTableViewCellViewModel: SeaCreatureDashboardTableViewCellViewModel?
    private var bugDashboardTableViewCellViewModel: BugDashboardTableViewCellViewModel?
    private var fossilDashboardTableViewCellViewModel: FossilDashboardTableViewCellViewModel?
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 13
        return view
    }()
    
    private let creatureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let creatureTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FinkHeavy", size: 20)
        label.textColor = .white
        return label
    }()
    
    private let creatureProgressView: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.trackTintColor = .white
        progressBar.progress = 0.5
        return progressBar
    }()
    
    private let creatureTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureFishCell(with viewModel: FishDashboardTableViewCellViewModel) {
        containerView.backgroundColor = UIColor(named: "ColorBlueRoyal")
        self.fishDashboardTableViewCellViewModel = viewModel
        if let url = viewModel.iconURL {
            creatureImageView.loadImage(url: url)
        }
        creatureTitleLabel.text = viewModel.titleText
        creatureProgressView.progress = viewModel.progressOfBar
        creatureTotalLabel.text = viewModel.totalText
        creatureProgressView.progressTintColor = UIColor(named: "ColorBlueOcean")
    }
    
    func configureSeaCreatureCell(with viewModel: SeaCreatureDashboardTableViewCellViewModel) {
        containerView.backgroundColor = UIColor(named: "ColorBlueNightLite")
        self.seaCreatureDashboardTableViewCellViewModel = viewModel
        if let url = viewModel.iconURL {
            creatureImageView.loadImage(url: url)
        }
        creatureTitleLabel.text = viewModel.titleText
        creatureProgressView.progress = viewModel.progressOfBar
        creatureTotalLabel.text = viewModel.totalText
        creatureProgressView.progressTintColor = UIColor(named: "ColorBlueRoyal")
    }
    
    func configureBugCell(with viewModel: BugDashboardTableViewCellViewModel) {
        containerView.backgroundColor = UIColor(named: "ColorGreenDark")
        self.bugDashboardTableViewCellViewModel = viewModel
        if let url = viewModel.iconURL {
            creatureImageView.loadImage(url: url)
        }
        creatureTitleLabel.text = viewModel.titleText
        creatureProgressView.progress = viewModel.progressOfBar
        creatureTotalLabel.text = viewModel.totalText
        creatureProgressView.progressTintColor = UIColor(named: "ColorGreenGrass")
    }
    
    func configureFossilCell(with viewModel: FossilDashboardTableViewCellViewModel) {
        containerView.backgroundColor = UIColor(named: "ColorBrownHeart")
        self.fossilDashboardTableViewCellViewModel = viewModel
        if let url = viewModel.imageURL {
            creatureImageView.loadImage(url: url)
        }
        creatureProgressView.progress = viewModel.progressOfBar
        creatureTotalLabel.text = viewModel.totalText
        creatureTitleLabel.text = viewModel.titleText
        creatureProgressView.progressTintColor = .brown
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(creatureImageView)
        containerView.addSubview(creatureTitleLabel)
        containerView.addSubview(creatureProgressView)
        containerView.addSubview(creatureTotalLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            creatureImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            creatureImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            creatureImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            creatureImageView.widthAnchor.constraint(equalToConstant: 60),
            creatureImageView.heightAnchor.constraint(equalToConstant: 60),
            
            creatureTitleLabel.leadingAnchor.constraint(equalTo: creatureImageView.trailingAnchor, constant: 16),
            creatureTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            creatureTotalLabel.topAnchor.constraint(equalTo: creatureImageView.centerYAnchor),
            
            creatureProgressView.topAnchor.constraint(equalTo: creatureTitleLabel.bottomAnchor, constant: 8),
            creatureProgressView.leadingAnchor.constraint(equalTo: creatureImageView.trailingAnchor, constant: 16),
            creatureProgressView.heightAnchor.constraint(equalToConstant: 2),
            
            creatureTotalLabel.leadingAnchor.constraint(equalTo: creatureProgressView.trailingAnchor, constant: 8),
            creatureTotalLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            creatureTotalLabel.centerYAnchor.constraint(equalTo: creatureProgressView.centerYAnchor),
        ])
    }
}
