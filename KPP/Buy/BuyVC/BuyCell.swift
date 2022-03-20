//
//  BuyCell.swift
//  KPP
//
//  Created by Михаил Шаговитов on 20.03.2022.
//
import UIKit
//import Firebase

class BuyCell: UITableViewCell {
    
    //static let nib = UINib(nibName: String(describing: ExhibitionCell.self), bundle: nil)

    private let nameCars = UILabel()
    private let imageCars = UIImageView()
    
    var viewBackground = UIView()
    var viewLabel = UIView()
    //private let imageProd = UIImageView()
    //unowned var delegate: ProductCellDescription?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupElements()
        setupViews()
    }
     
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func setupElements() {
        
        nameCars.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameCars.textColor = UIColor.black
        nameCars.translatesAutoresizingMaskIntoConstraints = false
        
        imageCars.contentMode = .scaleAspectFill
        imageCars.clipsToBounds = true
        imageCars.layer.cornerRadius = 10
        imageCars.isUserInteractionEnabled = true
        imageCars.translatesAutoresizingMaskIntoConstraints = false
        
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        viewBackground.translatesAutoresizingMaskIntoConstraints = false
        
        viewLabel.backgroundColor = UIColor.white
        viewLabel.layer.cornerRadius = 10
        viewBackground.layer.cornerRadius = 20

    }
    
//    public func getImageView() -> UIImageView {
//        return imageProd
//    }
//
//    public func getImage() -> UIImage? {
//        return imageProd.image
//    }
  
    func configure(with data: Cars){
        nameCars.text = data.name
        imageCars.image = data.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayuot()
    }
    
    private func setupViews() {
        contentView.addSubview(viewBackground)
        contentView.addSubview(viewLabel)
        contentView.addSubview(imageCars)
        contentView.addSubview(nameCars)

    }
    
    @objc
    func didTabButton() {
//        delegate?.didTabButton(nameProduct: nameProd.text ?? "", isFavorit: isFavorit ?? false)
    }
}

extension BuyCell {

    func setupLayuot() {
        NSLayoutConstraint.activate([
            
            viewBackground.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            viewBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            viewBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            viewBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            imageCars.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageCars.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            imageCars.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            imageCars.heightAnchor.constraint(equalToConstant: 200),
            
            viewLabel.topAnchor.constraint(equalTo: imageCars.bottomAnchor, constant: 7),
            viewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            viewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            viewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            nameCars.topAnchor.constraint(equalTo: imageCars.bottomAnchor, constant: 10),
            //nameCars.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameCars.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            nameCars.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
       ])
  }
}

    
extension BuyCell {
    
    static var nibSearch : UINib{
        return UINib(nibName: identifireBuy, bundle: nil)
    }
    
    static var identifireBuy : String{
        return String(describing: self)
    }
}
