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
            objectImageView.loadImage(url: url)
        }
        objectTitleLabel.text = viewModel.titleText
        objectProgressView.progress = viewModel.progressBarState
        objectTotalLabel.text = viewModel.totalText
        objectProgressView.progressTintColor = UIColor(named: "ColorBlueOcean")
    }
    
    func configureSeaCreatureCell(with viewModel: SeaCreatureDashboardTableViewCellViewModel) {
        containerView.backgroundColor = UIColor(named: "ColorBlueNightLite")
        self.seaCreatureDashboardTableViewCellViewModel = viewModel
        if let url = viewModel.iconURL {
            objectImageView.loadImage(url: url)
        }
        objectTitleLabel.text = viewModel.titleText
        objectProgressView.progressTintColor = UIColor(named: "ColorBlueRoyal")
        objectProgressView.progress = viewModel.progressBarState
        objectTotalLabel.text = viewModel.totalText
    }
    
    func configureBugCell(with viewModel: BugDashboardTableViewCellViewModel) {
        containerView.backgroundColor = UIColor(named: "ColorGreenDark")
        self.bugDashboardTableViewCellViewModel = viewModel
        if let url = viewModel.iconURL {
            objectImageView.loadImage(url: url)
        }
        objectTitleLabel.text = viewModel.titleText
        objectProgressView.progressTintColor = UIColor(named: "ColorGreenGrass")
        objectProgressView.progress = viewModel.progressBarState
        objectTotalLabel.text = viewModel.totalText
    }
    
    func configureFossilCell(with viewModel: FossilDashboardTableViewCellViewModel) {
        containerView.backgroundColor = UIColor(named: "ColorBrownHeart")
        self.fossilDashboardTableViewCellViewModel = viewModel
        if let url = viewModel.imageURL {
            objectImageView.loadImage(url: url)
        }
        objectTitleLabel.text = viewModel.titleText
        objectProgressView.progressTintColor = .brown
        objectProgressView.progress = viewModel.progressBarState
        objectTotalLabel.text = viewModel.totalText
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(objectImageView)
        containerView.addSubview(objectTitleLabel)
        containerView.addSubview(objectProgressView)
        containerView.addSubview(objectTotalLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            objectImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            objectImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            objectImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            objectImageView.widthAnchor.constraint(equalToConstant: 60),
            objectImageView.heightAnchor.constraint(equalToConstant: 60),
            
            objectTitleLabel.leadingAnchor.constraint(equalTo: objectImageView.trailingAnchor, constant: 16),
            objectTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            objectTotalLabel.topAnchor.constraint(equalTo: objectImageView.centerYAnchor),
            
            objectProgressView.topAnchor.constraint(equalTo: objectTitleLabel.bottomAnchor, constant: 8),
            objectProgressView.leadingAnchor.constraint(equalTo: objectImageView.trailingAnchor, constant: 16),
            objectProgressView.heightAnchor.constraint(equalToConstant: 2),
            
            objectTotalLabel.leadingAnchor.constraint(equalTo: objectProgressView.trailingAnchor, constant: 8),
            objectTotalLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            objectTotalLabel.centerYAnchor.constraint(equalTo: objectProgressView.centerYAnchor),
        ])
    }
}
