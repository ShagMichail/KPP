//
//  PhotoCell.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit

class GentlmenCell: UICollectionViewCell {

    private let imageGentlmenPhoto = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupElements()
    }
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func setupElements() {
        imageGentlmenPhoto.translatesAutoresizingMaskIntoConstraints = false
        imageGentlmenPhoto.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
        imageGentlmenPhoto.makeRounded()
    }
    
    func configure(with data: GentlmenPhoto){
        self.imageGentlmenPhoto.image = data.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayuot()
    }
    
    private func setupViews() {
        contentView.addSubview(imageGentlmenPhoto)
    }
}

extension GentlmenCell {
    
    func setupLayuot() {
        NSLayoutConstraint.activate([
            imageGentlmenPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageGentlmenPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageGentlmenPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageGentlmenPhoto.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50),
        
        ])
    }
}

extension GentlmenCell {
    
    static var nibGentlmenPhoto  : UINib{
        return UINib(nibName: identifireGentlmenPhoto, bundle: nil)
    }
    
    static var identifireGentlmenPhoto : String{
        return String(describing: self)
    }
}

