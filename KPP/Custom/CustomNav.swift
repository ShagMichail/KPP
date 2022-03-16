//
//  CustomNav.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import Foundation
import UIKit

class CustomNav: UIView {
    
    var navTitle = UILabel()
    var navButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(navTitle)
        addSubview(navButton)
        
        navTitle.translatesAutoresizingMaskIntoConstraints = false
    
        navTitle.textAlignment = .center
        navTitle.textColor = .white
        navButton.translatesAutoresizingMaskIntoConstraints = false
        navButton.imageView?.isUserInteractionEnabled = false
        navButton.tintColor = .white

    
        NSLayoutConstraint.activate([
            
            navTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            navTitle.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            
            navButton.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            navButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
