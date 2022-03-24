//
//  BuyManager.swift
//  KPP
//
//  Created by Михаил Шаговитов on 20.03.2022.
//

import Foundation
import UIKit

protocol BuyManagerProtocol {
    var output: BuyManagerOutput? { get set }
    
    func loadPhoto()
}

protocol BuyManagerOutput: AnyObject {
    func didReceive(_ cars: [Cars])
}

class BuyManager: BuyManagerProtocol {
    
    static let shared: BuyManagerProtocol = BuyManager()
    
    weak var output: BuyManagerOutput?
    
    private init() {}
    
    func loadPhoto() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let cars = [
                Cars(image: (UIImage(named: "chests") ?? #imageLiteral(resourceName: "house")), brand: "Mazda", model: "RX-7", horsepower: "150", year: "1995", fuel: "Бензин", countRegistration: 2, dtp: "Битый (2)", generation: "1(2008-2010)", mileage: "183.000", engineCapacity: "2.4", transmission: "Автомат", driveUnit: "Передний", equipment: "Люкс", bodyType: "Седан", color: "Черный", steeringWheel: "Левый", cost: "436.900", costLast: "450.000", deposit: false),
                Cars(image: (UIImage(named: "chests") ?? #imageLiteral(resourceName: "house")), brand: "Mazda", model: "RX-7", horsepower: "150", year: "1995", fuel: "Бензин", countRegistration: 2, dtp: "Битый (1)", generation: "1(2008-2010)", mileage: "183.000", engineCapacity: "2.4", transmission: "Автомат", driveUnit: "Передний", equipment: "Люкс", bodyType: "Седан", color: "Черный", steeringWheel: "Левый", cost: "436.900", costLast: "", deposit: false),
                Cars(image: (UIImage(named: "chests") ?? #imageLiteral(resourceName: "house")), brand: "Mazda", model: "RX-7", horsepower: "150", year: "1995", fuel: "Бензин", countRegistration: 2, dtp: "Не битый", generation: "1(2008-2010)", mileage: "183.000", engineCapacity: "2.4", transmission: "Автомат", driveUnit: "Передний", equipment: "Люкс", bodyType: "Седан", color: "Черный", steeringWheel: "Левый", cost: "436.900", costLast: "350.000", deposit: true),
            ]
            
            self.output?.didReceive(cars)
        }
    }
}
