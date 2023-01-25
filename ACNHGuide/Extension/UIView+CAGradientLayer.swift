//
//  UIView+CAGradientLayer.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 10/01/2023.
//

import UIKit

extension UIView {
    func applyGradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = self.bounds
        layer.addSublayer(gradientLayer)
        }
    
    func setCollectionViewBackground(collectionView: UICollectionView, colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = self.bounds
        collectionView.backgroundView = UIView()
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
    }
}
