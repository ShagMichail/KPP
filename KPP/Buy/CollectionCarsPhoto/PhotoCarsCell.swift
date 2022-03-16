//
//  PhotoCarsCell.swift
//  KPP
//
//  Created by Михаил Шаговитов on 11.03.2022.
//

import Foundation
import UIKit

class PhotoCarsCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}
