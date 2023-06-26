//
//  ImageView.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import UIKit
import Combine

extension UIImageView {
    func loadImage(url: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in UIImage(data: data) }
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    
    func makeShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 5, height: -3)
        self.layer.shadowRadius = 1
    }
}
