//
//  CarCardVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 23.03.2022.
//

import UIKit

class CarCardVC: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    var navBar: CustomNav = {
        let view = CustomNav()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //var auto = Cars(image: UIImage(), brand: String(), model: String(), horsepower: String(), year: String(), fuel: String(), countRegistration: Int(), dtp: Int(), generation: String(), mileage: String(), engineCapacity: String(), transmission: String(), driveUnit: String(), equipment: String(), bodyType: String(), color: String(), steeringWheel: String(), cost: String())
    
    private var costFlag = Bool()
    
    private let viewColor = UIView()
    private let viewCar = UIView()
    
    let carImageView = UIImageView()
    
    private let year = UILabel()
    private let generation = UILabel()
    private let mileage = UILabel()
    private let owner = UILabel()
    private let condition = UILabel()
//    private let modification = UILabel()
    private let engineCapacity = UILabel()
    private let enginesType = UILabel()
    private let transmission = UILabel()
    private let driveUnit = UILabel()
    private let equipment = UILabel()
    private let bodyType = UILabel()
    private let color = UILabel()
    private let steeringWheel = UILabel()
    private let cost = UILabel()
    
    private let yearCars = UILabel()
    private let generationCars = UILabel()
    private let mileageCars = UILabel()
    private let ownerCars = UILabel()
    private let conditionCars = UILabel()
    //private let dtpCars = UILabel()
    private let engineCapacityCars = UILabel()
    private let enginesTypeCars = UILabel()
    private let transmissionCars = UILabel()
    private let driveUnitCars = UILabel()
    private let equipmentCars = UILabel()
    private let bodyTypeCars = UILabel()
    private let colorCars = UILabel()
    private let steeringWheelCars = UILabel()
    private let costCars = UILabel()
    private let costLastCars = UILabel()
    private let brandCars = UILabel()
    private let modelCars = UILabel()
    
    private let carsCharacteristics = UILabel()
    
    private let question = UILabel()
    private let buttonCall: UIButton = {
        let button = UIButton(type: .system)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15)]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        let attriburedTitle = NSMutableAttributedString(string: "Позвонить",
                                                        attributes: atts)
        button.setAttributedTitle(attriburedTitle, for: .normal)
        
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddSubview()
        setupElement()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        
    }
    
    func configure(with data: Cars){
        yearCars.text = data.year
        generationCars.text = data.generation
        mileageCars.text = data.mileage
        ownerCars.text = String(data.countRegistration)
        conditionCars.text = data.dtp
        //dtpCars.text = String(data.dtp)
        engineCapacityCars.text = data.engineCapacity
        enginesTypeCars.text = data.fuel
        transmissionCars.text = data.transmission
        driveUnitCars.text = data.driveUnit
        equipmentCars.text = data.equipment
        bodyTypeCars.text = data.bodyType
        colorCars.text = data.color
        steeringWheelCars.text = data.steeringWheel
        costCars.text = data.cost
        brandCars.text = data.brand
        modelCars.text = data.model
        costLastCars.text = data.costLast
        
        if costLastCars.text != "" {
            costFlag = true
        } else {
            costFlag = false
        }
    }
    
    private func setupAddSubview(){
        
        view.addSubview(navBar)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        view.addSubview(carImageView)
        
        view.addSubview(viewColor)
        viewColor.addSubview(viewCar)
        viewCar.addSubview(brandCars)
        viewCar.addSubview(modelCars)
        viewCar.addSubview(costCars)
        viewCar.addSubview(cost)
        viewCar.addSubview(costLastCars)

        view.addSubview(carsCharacteristics)
        contentView.addSubview(year)
        contentView.addSubview(generation)
        contentView.addSubview(mileage)
        contentView.addSubview(owner)
        contentView.addSubview(condition)
//        view.addSubview(modification)
        contentView.addSubview(engineCapacity)
        contentView.addSubview(enginesType)
        contentView.addSubview(transmission)
        contentView.addSubview(driveUnit)
        contentView.addSubview(equipment)
        contentView.addSubview(bodyType)
        contentView.addSubview(color)
        contentView.addSubview(steeringWheel)

        contentView.addSubview(yearCars)
        contentView.addSubview(generationCars)
        contentView.addSubview(mileageCars)
        contentView.addSubview(ownerCars)
        contentView.addSubview(conditionCars)
        //contentView.addSubview(dtpCars)
        contentView.addSubview(engineCapacityCars)
        contentView.addSubview(enginesTypeCars)
        contentView.addSubview(transmissionCars)
        contentView.addSubview(driveUnitCars)
        contentView.addSubview(equipmentCars)
        contentView.addSubview(bodyTypeCars)
        contentView.addSubview(colorCars)
        contentView.addSubview(steeringWheelCars)
        
        view.addSubview(question)
        view.addSubview(buttonCall)
        
    }
    
    func setupNavBar(){
        navBar.navButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        navBar.navButton.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
    }
    
    private func setupElement(){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 385)
        scrollView.isUserInteractionEnabled = true
        
        view.backgroundColor = .systemBackground
        
        
        buttonCall.backgroundColor = navBar.backgroundColor
        
        viewCar.translatesAutoresizingMaskIntoConstraints = false
        viewCar.backgroundColor = UIColor.white
        viewCar.layer.cornerRadius = 10
        
        viewColor.translatesAutoresizingMaskIntoConstraints = false
        viewColor.backgroundColor = navBar.backgroundColor
        viewColor.layer.cornerRadius = 10
        
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        
        carsCharacteristics.translatesAutoresizingMaskIntoConstraints = false
        carsCharacteristics.text = "Характеристики и особенности автомобиля:"
        
        year.translatesAutoresizingMaskIntoConstraints = false
        year.text = "Год выпука:"
        
        generation.translatesAutoresizingMaskIntoConstraints = false
        generation.text = "Поколение:"
        
        mileage.translatesAutoresizingMaskIntoConstraints = false
        mileage.text = "Пробег, км:"
        
        owner.translatesAutoresizingMaskIntoConstraints = false
        owner.text = "Владельцев по ПТС:"
        
        condition.translatesAutoresizingMaskIntoConstraints = false
        condition.text = "Состояние:"
        
//        modification.translatesAutoresizingMaskIntoConstraints = false
//        modification.text = "Модификация:"
        
        engineCapacity.translatesAutoresizingMaskIntoConstraints = false
        engineCapacity.text = "Объем двигателя:"
        
        enginesType.translatesAutoresizingMaskIntoConstraints = false
        enginesType.text = "Тип двигателя:"
        
        transmission.translatesAutoresizingMaskIntoConstraints = false
        transmission.text = "Коробка передач:"
        
        driveUnit.translatesAutoresizingMaskIntoConstraints = false
        driveUnit.text = "Привод:"
        
        equipment.translatesAutoresizingMaskIntoConstraints = false
        equipment.text = "Комплектация:"
        
        bodyType.translatesAutoresizingMaskIntoConstraints = false
        bodyType.text = "Тип кузова:"
        
        color.translatesAutoresizingMaskIntoConstraints = false
        color.text = "Цвет:"
        
        steeringWheel.translatesAutoresizingMaskIntoConstraints = false
        steeringWheel.text = "Руль:"
        
        cost.translatesAutoresizingMaskIntoConstraints = false
        cost.text = "Цена:"
        cost.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        yearCars.translatesAutoresizingMaskIntoConstraints = false
        generationCars.translatesAutoresizingMaskIntoConstraints = false
        mileageCars.translatesAutoresizingMaskIntoConstraints = false
        ownerCars.translatesAutoresizingMaskIntoConstraints = false
        conditionCars.translatesAutoresizingMaskIntoConstraints = false
//        dtpCars.translatesAutoresizingMaskIntoConstraints = false
        engineCapacityCars.translatesAutoresizingMaskIntoConstraints = false
        enginesTypeCars.translatesAutoresizingMaskIntoConstraints = false
        transmissionCars.translatesAutoresizingMaskIntoConstraints = false
        driveUnitCars.translatesAutoresizingMaskIntoConstraints = false
        equipmentCars.translatesAutoresizingMaskIntoConstraints = false
        bodyTypeCars.translatesAutoresizingMaskIntoConstraints = false
        colorCars.translatesAutoresizingMaskIntoConstraints = false
        steeringWheelCars.translatesAutoresizingMaskIntoConstraints = false
        
        question.translatesAutoresizingMaskIntoConstraints = false
        question.text = "Понравилась данная пушка?! Не забудьте позвонить и забронировать!"
        question.numberOfLines = 0
        question.textAlignment = .center
        
        buttonCall.addTarget(self, action: #selector(sendButton), for: .touchUpInside)
        
        
        
        if costFlag {
            costCars.translatesAutoresizingMaskIntoConstraints = false
            costCars.font = UIFont.systemFont(ofSize: 25, weight: .regular)
            costCars.attributedText = costCars.text?.strikeThrough()

            costLastCars.translatesAutoresizingMaskIntoConstraints = false
            costLastCars.font = UIFont.systemFont(ofSize: 25, weight: .regular)
            NSLayoutConstraint.activate([
                costCars.topAnchor.constraint(equalTo: brandCars.bottomAnchor, constant: 7),
                costCars.leadingAnchor.constraint(equalTo: cost.trailingAnchor, constant: 3),

                costLastCars.topAnchor.constraint(equalTo: brandCars.bottomAnchor, constant: 7),
                costLastCars.leadingAnchor.constraint(equalTo: costCars.trailingAnchor, constant: 10),
            ])

        } else {

            costCars.translatesAutoresizingMaskIntoConstraints = false
            costCars.font = UIFont.systemFont(ofSize: 25, weight: .regular)

            NSLayoutConstraint.activate([

                costCars.topAnchor.constraint(equalTo: brandCars.bottomAnchor, constant: 7),
                costCars.leadingAnchor.constraint(equalTo: cost.trailingAnchor, constant: 3),
            ])
        }
        
        brandCars.translatesAutoresizingMaskIntoConstraints = false
        brandCars.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        modelCars.translatesAutoresizingMaskIntoConstraints = false
        modelCars.font = UIFont.systemFont(ofSize: 25, weight: .regular)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navBar.heightAnchor.constraint(equalToConstant: 80),
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: carsCharacteristics.bottomAnchor, constant: 9),
            scrollView.bottomAnchor.constraint(equalTo: question.topAnchor, constant: -12),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            carImageView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 5),
            carImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            carImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            carImageView.heightAnchor.constraint(equalToConstant: 250),
            
            viewColor.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 10),
            viewColor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            viewColor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            viewColor.heightAnchor.constraint(equalToConstant: 100),

            viewCar.topAnchor.constraint(equalTo: viewColor.topAnchor, constant: 7),
            viewCar.leadingAnchor.constraint(equalTo: viewColor.leadingAnchor, constant: 7),
            viewCar.trailingAnchor.constraint(equalTo: viewColor.trailingAnchor, constant: -7),
            viewCar.bottomAnchor.constraint(equalTo: viewColor.bottomAnchor, constant: -7),

            brandCars.topAnchor.constraint(equalTo: viewCar.topAnchor, constant: 10),
            brandCars.leadingAnchor.constraint(equalTo: viewCar.leadingAnchor, constant: 10),

            modelCars.topAnchor.constraint(equalTo: viewCar.topAnchor, constant: 10),
            modelCars.leadingAnchor.constraint(equalTo: brandCars.trailingAnchor, constant: 3),

            cost.topAnchor.constraint(equalTo: brandCars.bottomAnchor, constant: 7),
            cost.leadingAnchor.constraint(equalTo: viewCar.leadingAnchor, constant: 10),

            carsCharacteristics.topAnchor.constraint(equalTo: viewColor.bottomAnchor, constant: 10),
            carsCharacteristics.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            carsCharacteristics.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            year.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            year.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            yearCars.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            yearCars.leadingAnchor.constraint(equalTo: year.trailingAnchor, constant: 5),
            
            generation.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 10),
            generation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            generationCars.topAnchor.constraint(equalTo: year.bottomAnchor, constant: 10),
            generationCars.leadingAnchor.constraint(equalTo: generation.trailingAnchor, constant: 5),
            
            mileage.topAnchor.constraint(equalTo: generation.bottomAnchor, constant: 10),
            mileage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            mileageCars.topAnchor.constraint(equalTo: generation.bottomAnchor, constant: 10),
            mileageCars.leadingAnchor.constraint(equalTo: mileage.trailingAnchor, constant: 5),
            
            owner.topAnchor.constraint(equalTo: mileage.bottomAnchor, constant: 10),
            owner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            ownerCars.topAnchor.constraint(equalTo: mileage.bottomAnchor, constant: 10),
            ownerCars.leadingAnchor.constraint(equalTo: owner.trailingAnchor, constant: 5),
            
            condition.topAnchor.constraint(equalTo: owner.bottomAnchor, constant: 10),
            condition.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            conditionCars.topAnchor.constraint(equalTo: owner.bottomAnchor, constant: 10),
            conditionCars.leadingAnchor.constraint(equalTo: condition.trailingAnchor, constant: 5),
            
            engineCapacity.topAnchor.constraint(equalTo: condition.bottomAnchor, constant: 10),
            engineCapacity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            engineCapacityCars.topAnchor.constraint(equalTo: condition.bottomAnchor, constant: 10),
            engineCapacityCars.leadingAnchor.constraint(equalTo: engineCapacity.trailingAnchor, constant: 5),
            
            enginesType.topAnchor.constraint(equalTo: engineCapacity.bottomAnchor, constant: 10),
            enginesType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            enginesTypeCars.topAnchor.constraint(equalTo: engineCapacity.bottomAnchor, constant: 10),
            enginesTypeCars.leadingAnchor.constraint(equalTo: enginesType.trailingAnchor, constant: 5),
            
            transmission.topAnchor.constraint(equalTo: enginesType.bottomAnchor, constant: 10),
            transmission.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            transmissionCars.topAnchor.constraint(equalTo: enginesType.bottomAnchor, constant: 10),
            transmissionCars.leadingAnchor.constraint(equalTo: transmission.trailingAnchor, constant: 5),
            
            driveUnit.topAnchor.constraint(equalTo: transmission.bottomAnchor, constant: 10),
            driveUnit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            driveUnitCars.topAnchor.constraint(equalTo: transmission.bottomAnchor, constant: 10),
            driveUnitCars.leadingAnchor.constraint(equalTo: driveUnit.trailingAnchor, constant: 5),
            
            equipment.topAnchor.constraint(equalTo: driveUnit.bottomAnchor, constant: 10),
            equipment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            equipmentCars.topAnchor.constraint(equalTo: driveUnit.bottomAnchor, constant: 10),
            equipmentCars.leadingAnchor.constraint(equalTo: equipment.trailingAnchor, constant: 5),
            
            bodyType.topAnchor.constraint(equalTo: equipment.bottomAnchor, constant: 10),
            bodyType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            bodyTypeCars.topAnchor.constraint(equalTo: equipment.bottomAnchor, constant: 10),
            bodyTypeCars.leadingAnchor.constraint(equalTo: bodyType.trailingAnchor, constant: 5),
            
            color.topAnchor.constraint(equalTo: bodyType.bottomAnchor, constant: 10),
            color.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            colorCars.topAnchor.constraint(equalTo: bodyType.bottomAnchor, constant: 10),
            colorCars.leadingAnchor.constraint(equalTo: color.trailingAnchor, constant: 5),
            
            steeringWheel.topAnchor.constraint(equalTo: color.bottomAnchor, constant: 10),
            steeringWheel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            steeringWheelCars.topAnchor.constraint(equalTo: color.bottomAnchor, constant: 10),
            steeringWheelCars.leadingAnchor.constraint(equalTo: steeringWheel.trailingAnchor, constant: 5),
            
            question.bottomAnchor.constraint(equalTo: buttonCall.topAnchor, constant: -15),
            question.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            question.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            buttonCall.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            buttonCall.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width / 4),
            buttonCall.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(UIScreen.main.bounds.width / 4)),
            buttonCall.heightAnchor.constraint(equalToConstant: 35),
            
            ])
    }
    
    @objc func didTapMenuButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sendButton(){
        let url: NSURL = URL(string: "TEL://89096833671") as! NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        print("ghg")
    }


}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

