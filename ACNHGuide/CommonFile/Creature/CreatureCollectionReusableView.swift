//
//  CreatureCollectionReusableView.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 11/01/2023.
//

import UIKit
import Combine

final class CreatureCollectionReusableView: UICollectionReusableView {
    
    var cancellables = Set<AnyCancellable>()
    private let switchButtonSubject = PassthroughSubject<Void, Never>()
    var switchButtonAction: AnyPublisher<Void, Never> {
        switchButtonSubject.eraseToAnyPublisher()
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "FinkHeavy", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var switchHemisphereButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.up.arrow.down.square"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapSwitchHemisphereButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeaderLabel(with text: String) {
        headerLabel.text = text
    }
    
    @objc func didTapSwitchHemisphereButton() {
        switchButtonSubject.send()
    }
    
    private func addSubviews() {
        addSubview(headerLabel)
        addSubview(switchHemisphereButton)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            switchHemisphereButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            switchHemisphereButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            switchHemisphereButton.widthAnchor.constraint(equalToConstant: 47),
            switchHemisphereButton.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
}

