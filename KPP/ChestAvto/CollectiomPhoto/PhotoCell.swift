//
//  PhotoCell.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    private let imagePhoto = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupElements()
    }
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func setupElements() {
        imagePhoto.translatesAutoresizingMaskIntoConstraints = false
        imagePhoto.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
        imagePhoto.makeRounded()
    }

    func configure(with data: Photo){
        self.imagePhoto.image = data.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayuot()
    }
    
    private func setupViews() {
        contentView.addSubview(imagePhoto)
    }
}

extension PhotoCell {
    
    func setupLayuot() {
        NSLayoutConstraint.activate([
            imagePhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imagePhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imagePhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imagePhoto.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50),

        ])
    }
}

extension PhotoCell {
    
    static var nibPhoto  : UINib{
        return UINib(nibName: identifirePhoto, bundle: nil)
    }
    
    static var identifirePhoto : String{
        return String(describing: self)
    }
}

