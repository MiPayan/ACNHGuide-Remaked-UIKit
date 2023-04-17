//
//  ImageView.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 5, height: -3)
        self.layer.shadowRadius = 1
    }
}
