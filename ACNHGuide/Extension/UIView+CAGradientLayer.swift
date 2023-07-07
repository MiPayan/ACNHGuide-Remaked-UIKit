//
//  UIView+CAGradientLayer.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 10/01/2023.
//

import UIKit

extension UIView {
    func setCollectionViewBackground(collectionView: UICollectionView, colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = self.bounds
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
    }
    
    func setUpContentView(color: String) {
        self.backgroundColor = UIColor(named: color)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
