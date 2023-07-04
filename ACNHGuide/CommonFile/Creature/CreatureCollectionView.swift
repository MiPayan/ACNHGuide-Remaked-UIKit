//
//  CreatureCollectionView.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 04/07/2023.
//

import UIKit

final class CreatureCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        super.init(frame: frame, collectionViewLayout: flowLayout)
        register(
            CreatureCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "AdaptiveHeader"
        )
        translatesAutoresizingMaskIntoConstraints = false
        setCollectionViewLayout(flowLayout, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
