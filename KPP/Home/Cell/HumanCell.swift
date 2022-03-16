//
//  Cell.swift
//  KPP
//
//  Created by Михаил Шаговитов on 09.03.2022.
//

import UIKit

class HumanCell: UICollectionViewCell {

    private let imageHuman = UIImageView()
    private let link = UILabel()
    private let containerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupElements()
    }
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func setupElements() {

        imageHuman.translatesAutoresizingMaskIntoConstraints = false
        imageHuman.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
        imageHuman.makeRounded()
        
        link.textColor = UIColor.black
        link.font = UIFont(name: "TimesNewRomanPSMT", size: 20)
        link.textAlignment = .center
        link.translatesAutoresizingMaskIntoConstraints = false
        //link.text = "zheki444"
        link.numberOfLines = 0
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 1.5
                containerView.layer.shadowOffset = .init(width: 0.5, height: 0.5)
                containerView.layer.shadowOpacity = 0.8
                containerView.layer.cornerRadius = 8
                containerView.backgroundColor = .white
    }

    func configure(with data: Human){
        self.imageHuman.image = data.image
        self.link.text = data.link
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayuot()
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageHuman)
        containerView.addSubview(link)
    }
}

extension HumanCell {
    
    func setupLayuot() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
 
            imageHuman.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            imageHuman.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            imageHuman.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            imageHuman.widthAnchor.constraint(equalToConstant: 100),
            imageHuman.heightAnchor.constraint(equalToConstant: 100),

            link.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            link.leadingAnchor.constraint(equalTo: imageHuman.trailingAnchor, constant: 20),
        ])
    }
}

extension HumanCell {
    
    static var nib  : UINib{
        return UINib(nibName: identifire, bundle: nil)
    }
    
    static var identifire : String{
        return String(describing: self)
    }
}


extension UIImageView {
    //MARK: Функция позволяет сделать круглое изображение
    func makeRounded() {
        self.layer.borderWidth = 0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }

}
