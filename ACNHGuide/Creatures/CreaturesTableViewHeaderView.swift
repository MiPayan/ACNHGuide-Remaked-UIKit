//
//  CreatureTableViewHeaderView.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 07/06/2023.
//

import UIKit

final class CreaturesTableViewHeaderView: UITableViewHeaderFooterView {

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeaderLabel(with text: String) {
        headerLabel.text = text
    }
    
    private func addSubviews() {
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
