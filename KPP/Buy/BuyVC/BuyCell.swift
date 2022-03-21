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
    private let modelCars = UILabel()
    private let yearCars = UILabel()
    private let horseCars = UILabel()
    //private let fuelCars = UILabel()
    private let countRegistration = UILabel()
    private let countDTP = UILabel()
    
    private let imageCarsLabel = UIImageView()
    private let imageData = UIImageView()
    private let imageMotor = UIImageView()
    private let imageDTP = UIImageView()
    private let imageRegistration = UIImageView()
    //private let imageFuel = UIImageView()
    
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
        
        yearCars.translatesAutoresizingMaskIntoConstraints = false
        modelCars.translatesAutoresizingMaskIntoConstraints = false
        horseCars.translatesAutoresizingMaskIntoConstraints = false
        countDTP.translatesAutoresizingMaskIntoConstraints = false
        countRegistration.translatesAutoresizingMaskIntoConstraints = false
        
        viewLabel.backgroundColor = UIColor.white
        viewLabel.layer.cornerRadius = 10
        viewBackground.layer.cornerRadius = 20
        
        imageCarsLabel.translatesAutoresizingMaskIntoConstraints = false
        imageData.translatesAutoresizingMaskIntoConstraints = false
        imageMotor.translatesAutoresizingMaskIntoConstraints = false
        imageDTP.translatesAutoresizingMaskIntoConstraints = false
        imageRegistration.translatesAutoresizingMaskIntoConstraints = false
        //imageFuel.translatesAutoresizingMaskIntoConstraints = false
        
        imageCarsLabel.image = UIImage(named: "cars")
        imageData.image = UIImage(named: "data")
        imageMotor.image = UIImage(named: "motor")
        imageDTP.image = UIImage(named: "dtp")
        imageRegistration.image = UIImage(named: "registration")
        //imageFuel.image = UIImage(named: "fuel")

    }
    
//    public func getImageView() -> UIImageView {
//        return imageProd
//    }
//
//    public func getImage() -> UIImage? {
//        return imageProd.image
//    }
  
    func configure(with data: Cars){
        nameCars.text = data.brand
        imageCars.image = data.image
        horseCars.text = data.horsepower + " л.с. " + data.fuel
        modelCars.text = data.model
        yearCars.text = data.year + " год"
        //fuelCars.text = data.fuel
        countRegistration.text = String(data.countRegistration)
        countDTP.text = String(data.dtp)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayuot()
    }
    
    private func setupViews() {
        contentView.addSubview(viewBackground)
        contentView.addSubview(viewLabel)
        contentView.addSubview(imageCars)
        
        contentView.addSubview(imageCarsLabel)
        contentView.addSubview(nameCars)
        contentView.addSubview(modelCars)
        
        contentView.addSubview(imageMotor)
        contentView.addSubview(horseCars)
        
        contentView.addSubview(imageData)
        contentView.addSubview(yearCars)
        
        contentView.addSubview(imageDTP)
        contentView.addSubview(countDTP)
        
//        contentView.addSubview(imageFuel)
//        contentView.addSubview(fuelCars)
        
        contentView.addSubview(imageRegistration)
        contentView.addSubview(countRegistration)

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
            
            imageCarsLabel.topAnchor.constraint(equalTo: viewLabel.topAnchor, constant: 0),
            imageCarsLabel.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: 10),
            imageCarsLabel.heightAnchor.constraint(equalToConstant: 25),
            imageCarsLabel.widthAnchor.constraint(equalToConstant: 25),
            
            nameCars.topAnchor.constraint(equalTo: viewLabel.topAnchor, constant: 7),
            nameCars.leadingAnchor.constraint(equalTo: imageCarsLabel.trailingAnchor, constant: 7),
            
            modelCars.topAnchor.constraint(equalTo: viewLabel.topAnchor, constant: 7),
            modelCars.leadingAnchor.constraint(equalTo: nameCars.trailingAnchor, constant: 5),
            
            imageMotor.topAnchor.constraint(equalTo: imageCarsLabel.bottomAnchor, constant: 10),
            imageMotor.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: 10),
            imageMotor.heightAnchor.constraint(equalToConstant: 25),
            imageMotor.widthAnchor.constraint(equalToConstant: 25),
                        
            horseCars.topAnchor.constraint(equalTo: imageCarsLabel.bottomAnchor, constant: 10),
            horseCars.leadingAnchor.constraint(equalTo: imageMotor.trailingAnchor, constant: 7),
            
            imageData.topAnchor.constraint(equalTo: imageMotor.bottomAnchor, constant: 10),
            imageData.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: 10),
            imageData.heightAnchor.constraint(equalToConstant: 25),
            imageData.widthAnchor.constraint(equalToConstant: 25),
            
            yearCars.topAnchor.constraint(equalTo: imageMotor.bottomAnchor, constant: 10),
            yearCars.leadingAnchor.constraint(equalTo: imageData.trailingAnchor, constant: 7),
            
            imageDTP.topAnchor.constraint(equalTo: imageCarsLabel.bottomAnchor, constant: 10),
            imageDTP.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: UIScreen.main.bounds.width/2),
            imageDTP.heightAnchor.constraint(equalToConstant: 25),
            imageDTP.widthAnchor.constraint(equalToConstant: 25),
            
            countDTP.topAnchor.constraint(equalTo: imageCarsLabel.bottomAnchor, constant: 7),
            countDTP.leadingAnchor.constraint(equalTo: imageDTP.trailingAnchor, constant: 10),
            
            
            imageRegistration.topAnchor.constraint(equalTo: imageDTP.bottomAnchor, constant: 10),
            imageRegistration.leadingAnchor.constraint(equalTo: viewLabel.leadingAnchor, constant: UIScreen.main.bounds.width/2),
            imageRegistration.heightAnchor.constraint(equalToConstant: 25),
            imageRegistration.widthAnchor.constraint(equalToConstant: 25),
            
            countRegistration.topAnchor.constraint(equalTo: imageDTP.bottomAnchor, constant: 10),
            countRegistration.leadingAnchor.constraint(equalTo: imageRegistration.trailingAnchor, constant: 7),
            
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
