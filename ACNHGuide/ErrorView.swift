//
//  ErrorView.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 19/01/2023.
//

import UIKit

final class ErrorView: UIView {
    
    weak var errorDelegate: ErrorViewDelegate?
    private var containerErrorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "ColorErrorButton")
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private var errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "errorImage")
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = UIColor(named: "ColorErrorLabel")
        label.font = UIFont(name: "FinkHeavy", size: 15)
        label.text = "A problem has occurred.\nCheck your internet connection and retry."
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        button.tintColor = UIColor(named: "ColorErrorButton")
        button.configuration = .borderedProminent()
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapRefreshButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "ColorSand")
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ErrorView {
    func setBlurEffectBackground() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    @objc func didTapRefreshButton() {
        errorDelegate?.didTapRefreshButton()
    }
    
    func addSubviews() {
        addSubview(containerErrorView)
        containerErrorView.addSubview(errorImageView)
        containerErrorView.addSubview(errorLabel)
        containerErrorView.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            containerErrorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerErrorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerErrorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            containerErrorView.heightAnchor.constraint(equalTo: containerErrorView.widthAnchor),
            
            errorImageView.topAnchor.constraint(equalTo: containerErrorView.topAnchor, constant: 8),
            errorImageView.leadingAnchor.constraint(equalTo: containerErrorView.leadingAnchor, constant: 8),
            errorImageView.trailingAnchor.constraint(equalTo: containerErrorView.trailingAnchor, constant: -8),
            
            errorLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: -10),
            errorLabel.leadingAnchor.constraint(equalTo: containerErrorView.leadingAnchor, constant: 8),
            errorLabel.trailingAnchor.constraint(equalTo: containerErrorView.trailingAnchor, constant: -8),
            errorLabel.heightAnchor.constraint(equalToConstant: 60),
            
            refreshButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            refreshButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 8),
            refreshButton.bottomAnchor.constraint(equalTo: containerErrorView.bottomAnchor, constant: -8),
            refreshButton.widthAnchor.constraint(equalToConstant: 60),
            refreshButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
