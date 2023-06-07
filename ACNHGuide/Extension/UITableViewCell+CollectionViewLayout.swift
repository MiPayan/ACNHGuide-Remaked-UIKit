//
//  UITableViewCell+CollectionViewLayout.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 04/04/2023.
//

import UIKit

//extension UITableViewCell: UICollectionViewDelegateFlowLayout {
//    
//    // Defined margins around each section.
//    public func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAt section: Int
//    ) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 8.0, left: 32.0, bottom: 8.0, right: 32.0)
//    }
//    
//    // Defined the width and height of each element in pixels.
//    public func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
//        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
//        return CGSize(width: widthPerItem - 24, height: 60)
//    }
//}
