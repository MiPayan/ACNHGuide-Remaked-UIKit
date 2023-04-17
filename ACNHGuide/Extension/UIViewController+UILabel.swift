//
//  UIViewController+UILabel.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 04/04/2023.
//

import UIKit

extension UIViewController {
    func showToast(with text: String) {
        let toastLabel = UILabel(
            frame: CGRect(
                x: self.view.frame.size.width / 2 - 125,
                y: self.view.frame.size.height / 4 - 150,
                width: 250,
                height: 50
            )
        )
        let redCustomColor = UIColor(red: 161/255, green: 110/255, blue: 106/255, alpha: 1)
        toastLabel.backgroundColor = redCustomColor
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.numberOfLines = 0
        toastLabel.text = text
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
