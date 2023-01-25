//
//  DashboardView.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 24/01/2023.
//

import UIKit

final class DashboardView: UIView {
    
    private var fishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "fish")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private var fishTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FinkHeavy", size: 17)
        label.textColor = .white
        label.text = "Fishes"
        return label
    }()
    
    private var fishProgressView: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progressTintColor = .white
        progressBar.trackTintColor = .blue
        progressBar.progress = 0.5
        return progressBar
    }()
    
    private var fishTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FinkHeavy", size: 17)
        label.textColor = .white
        label.text = "40/80"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DashboardView {
    func addSubviews() {
        addSubview(fishImageView)
        addSubview(fishTitleLabel)
        addSubview(fishProgressView)
        addSubview(fishTotalLabel)
        
        NSLayoutConstraint.activate([
            fishImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            fishImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            fishImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            fishImageView.widthAnchor.constraint(equalTo: fishImageView.heightAnchor, multiplier: 1),
            
            fishTitleLabel.topAnchor.constraint(equalTo: fishImageView.topAnchor),
            fishTitleLabel.leadingAnchor.constraint(equalTo: fishImageView.trailingAnchor, constant: 8),
            fishTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            fishProgressView.topAnchor.constraint(equalTo: fishTitleLabel.bottomAnchor, constant: 4),
            fishProgressView.leadingAnchor.constraint(equalTo: fishImageView.trailingAnchor, constant: 8),
            fishProgressView.heightAnchor.constraint(equalToConstant: 1),
            
            fishTotalLabel.leadingAnchor.constraint(equalTo: fishProgressView.trailingAnchor, constant: 4),
            fishTotalLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            fishTotalLabel.centerYAnchor.constraint(equalTo: fishProgressView.centerYAnchor),
        ])
    }
}
