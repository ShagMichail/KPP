//
//  WorkshopCell.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit

class WorkshopCell: UICollectionViewCell {

    private let imageWorkshopPhoto = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupElements()
    }
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func setupElements() {

        imageWorkshopPhoto.translatesAutoresizingMaskIntoConstraints = false
        imageWorkshopPhoto.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
        imageWorkshopPhoto.makeRounded()
    }
    
    func configure(with data: WorkshopPhoto){
        self.imageWorkshopPhoto.image = data.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayuot()
    }
    
    private func setupViews() {
        contentView.addSubview(imageWorkshopPhoto)
    }
}

extension WorkshopCell {
    
    func setupLayuot() {
        NSLayoutConstraint.activate([
            imageWorkshopPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageWorkshopPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageWorkshopPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageWorkshopPhoto.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50),
        ])
    }
}

extension WorkshopCell {
    
    static var nibWorkshopPhoto  : UINib{
        return UINib(nibName: identifireWorkshopPhoto, bundle: nil)
    }
    
    static var identifireWorkshopPhoto : String{
        return String(describing: self)
    }
}

